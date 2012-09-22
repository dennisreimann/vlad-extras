# encoding: utf-8
#
# This recipe provides setup and maintenance tasks for Rails apps hosted on
# [Uberspace](http://uberspace.de). Most of this recipe has been inspired by
# [uberspacify](https://github.com/yeah/uberspacify), a gem which provides
# this functionality for Capistrano.
#
# Tasks:
#
#   - vlad:uberspace:setup # all-in-one setup task
#   - vlad:uberspace:setup_svscan
#   - vlad:uberspace:setup_service
#   - vlad:uberspace:setup_domain_symlink
#   - vlad:uberspace:create_database_yml
#   - vlad:uberspace:create_reverse_proxy_htaccess
#   - vlad:uberspace:reload_service
#   - vlad:uberspace:remove_service
#   - vlad:start_app
#   - vlad:restart_app
#   - vlad:stop_app
#
# Example Configuration:
#
#   set :app_server_port, 87654
#   set :app_server_start_cmd, "#{bundle_cmd} exec thin start -p #{app_server_port} -e #{rails_env}"
#
# Notes:
#
#   The deploy_to gets set for you, because the rails code needs to live somewhere
#   under /var/www/virtual/ so that Apache can access it. It's got a sane default
#   which you can override as long as you keep the above in mind.
#   The uberspace_home and uberspace_service variables don't need to be touched.
#
#   Your setup tasks may look like this, if you bring your own database.yml (usually
#   with vlad:copy:shared) you can remove the vlad:uberspace:create_database_yml task:
#
#   set :setup_tasks, %w(
#     vlad:setup_app
#     vlad:copy:shared
#     vlad:assets:create_shared_dir
#     vlad:uberspace:setup
#     vlad:uberspace:create_database_yml
#   )
#
#   Unless you ship your own public/.htaccess file (which may include custom config)
#   you should include the vlad:uberspace:create_reverse_proxy_htaccess after the
#   vlad:update task, so that everything works as expected:
#
#   set :deploy_tasks, %w(
#     vlad:update
#     vlad:uberspace:create_reverse_proxy_htaccess
#     [...]
#   )

set :deploy_to,         "/var/www/virtual/#{user}/rails/#{application}"
set :uberspace_home,    "/home/#{user}"
set :uberspace_service, "#{uberspace_home}/service/rails-#{application}"

namespace :vlad do

  namespace :uberspace do

    desc 'Setup your Uberspace for deploying a Rails app'
    remote_task :setup do
      %w(svscan service domain_symlink).each do |task|
        Rake::Task["vlad:uberspace:setup_#{task}"].invoke
      end
    end

    desc 'Setup custom services for your user'
    remote_task :setup_svscan do
      puts '[Uberspace] Setup svscan'
      run 'uberspace-setup-svscan ; echo' # echo to ensure non-error exit
    end

    desc 'Setup service script for the app'
    remote_task :setup_service do
      puts '[Uberspace] Setup service'
      unless app_server_start_cmd
        raise(Rake::ConfigurationError,
          'Please specify the application server start command via the :app_server_start_cmd variable')
      end
      etc_dir = "#{uberspace_home}/etc/run-rails-#{application}"
      # install
      run "mkdir -p #{etc_dir}"
      run "mkdir -p #{etc_dir}/log"
      put "#{etc_dir}/run" do
        <<-EOF
#!/bin/bash
export HOME=#{uberspace_home}
source $HOME/.bash_profile
cd #{current_path}
exec #{app_server_start_cmd} 2>&1
          EOF
      end
      put "#{etc_dir}/log/run" do
        <<-EOF
#!/bin/sh
exec multilog t ./main
        EOF
      end
      run "chmod +x #{etc_dir}/run"
      run "chmod +x #{etc_dir}/log/run"
      run "ln -nfs #{etc_dir} #{uberspace_service}"
    end

    desc 'Symlink domain to current path'
    remote_task :setup_domain_symlink do
      puts '[Uberspace] Setup domain symlink'
      # ensure that there is a current public path we can symlink to
      Rake::Task['vlad:update'].invoke unless VladExtras::Remote.exists?(current_path)
      public_path = "#{current_path}/public"
      domain_path = "/var/www/virtual/#{user}/#{domain}"
      run "mkdir -p #{public_path}" unless VladExtras::Remote.exists?(public_path)
      run "ln -nfs #{public_path} #{domain_path}"
    end

    desc 'Creates shared/config/database.yml from your my.cnf'
    remote_task :create_database_yml do
      puts '[Uberspace] Create database.yml'
      database_yml = "#{shared_path}/config/database.yml"
      db_conf = run "cat #{uberspace_home}/.my.cnf"
      db_port = db_conf.match(/^port=(\w+)/)[1]
      db_username = db_conf.match(/^user=(\w+)/)[1]
      db_password = db_conf.match(/^password=(\w+)/)[1]
      db_socket = db_conf.match(/^socket=(.*)$/)[1]
      content = <<-EOF
#{rails_env}:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  pool: 5
  host: localhost
  port: #{db_port}
  database: #{user}_#{application}
  username: #{db_username}
  password: #{db_password}
  socket: #{db_socket}
      EOF
      # check for already existing htaccess
      if VladExtras::Remote.exists?(database_yml)
        puts "\nYou already have a custom database.yml, located at\n#{database_yml}"
        puts "Please verify that it contains the following lines in order to work properly:"
        puts "\n#{content}\n"
      else
        # otherwise install it
        unless app_server_port
          raise(Rake::ConfigurationError,
            'Please specify the application server port via the :app_server_port variable')
        end
        run "mkdir -p #{File.dirname(database_yml)}"
        put database_yml do
          content
        end
        run "chmod +r #{database_yml}"
      end
    end

    desc 'Creates .htaccess with Apache reverse proxy config'
    remote_task :create_reverse_proxy_htaccess do
      puts '[Uberspace] Setup Apache reverse proxy'
      htaccess = "#{current_path}/public/.htaccess"
      content = <<-EOF
RewriteEngine On
RewriteBase /

# ensure the browser supports gzip encoding
RewriteCond %{HTTP:Accept-Encoding} \\b(x-)?gzip\\b
RewriteCond %{REQUEST_FILENAME}.gz -s
RewriteRule ^(.+) $1.gz [L]

# ensure correct Content-Type and add encoding header
<FilesMatch \\.css\\.gz$>
  ForceType text/css
  Header set Content-Encoding gzip
</FilesMatch>

<FilesMatch \\.js\\.gz$>
  ForceType text/javascript
  Header set Content-Encoding gzip
</FilesMatch>

# cache assets like forever
<FilesMatch \\.(js|css|gz|jpe?g|gif|png|ico)$>
  Header unset ETag
  FileETag None
  ExpiresActive On
  ExpiresDefault "access plus 1 year"
</FilesMatch>

# maintenance mode
ErrorDocument 503 /system/maintenance.html
RewriteCond %{REQUEST_URI} !.(css|gif|jpg|png)$
RewriteCond #{current_path}/public/system/maintenance.html -f
RewriteCond %{SCRIPT_FILENAME} !maintenance.html
RewriteRule ^.*$ - [redirect=503,last]

# let rails handle everything else
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ http://localhost:#{app_server_port}/$1 [P]
      EOF
      # check for already existing htaccess
      if VladExtras::Remote.exists?(htaccess)
        puts "\nYou already have a custom .htaccess, located at\n#{htaccess}"
        puts "Please verify that it contains the following lines in order to work properly:"
        puts "\n#{content}\n"
      else
        # otherwise install it
        unless app_server_port
          raise(Rake::ConfigurationError,
            'Please specify the application server port via the :app_server_port variable')
        end
        put htaccess do
          content
        end
        run "chmod +r #{htaccess}"
      end
    end

    desc 'Reloads service script'
    remote_task :reload_service do
      puts '[Uberspace] Reload service'
      run "svc -h #{uberspace_service}"
    end

    desc 'Removes service script'
    remote_task :remove_service do
      puts '[Uberspace] Remove service'
      run "cd #{uberspace_service}"
      run "rm #{uberspace_service}"
      run "svc -dx . log"
      run "rm -rf #{uberspace_home}/etc/run-rails-#{application}"
    end
  end

  desc 'Starts the application server'
  remote_task :start_app, :roles => :app do
    run "svc -u #{uberspace_service}"
  end

  desc 'Stops the application server'
  remote_task :stop_app, :roles => :app do
    run "svc -d #{uberspace_service}"
  end

  desc 'Restarts the application server'
  remote_task :restart_app, :roles => :app do
    run "svc -du #{uberspace_service}"
  end

end
