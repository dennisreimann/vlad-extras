# encoding: utf-8
#
# Tasks:
#
#   - vlad:start_web
#   - vlad:restart_web
#   - vlad:stop_web
#   - vlad:start             # also starts the app server
#   - vlad:stop              # also stops the app server
#   - vlad:nginx:reload      # reloads web server configuration
#   - vlad:nginx:configtest
#   - vlad:nginx:status
#   - vlad:nginx:terminate
#
# Example Configuration:
#
#   set :web_command, '/etc/init.d/nginx'

namespace :vlad do

  set(:web_command) { '/etc/init.d/nginx' }

  %w(start restart stop).each do |task|
    desc "#{task.capitalize} the web server"
    remote_task "#{task}_web".to_sym, :roles => :web do
      puts "[Nginx] #{task.capitalize}"
      sudo "#{web_command} #{task}"
    end
  end

  %w(start stop).each do |task|
    desc "#{task.capitalize} the web and app servers"
    remote_task task.to_sym do
      Rake::Task["vlad:#{task}_app"].invoke
      Rake::Task["vlad:#{task}_web"].invoke
    end
  end

  namespace :nginx do

    desc 'Reload the web server'
    remote_task :reload, :roles => :web do
      puts '[Nginx] Reloading config'
      sudo "#{web_command} force-reload"
    end

    %w(terminate status configtest).each do |task|
      desc "#{task.capitalize} the web server"
      remote_task task.to_sym, :roles => :web do
        puts '[Nginx] #{task.capitalize}'
        sudo "#{web_command} #{task}"
      end
    end

  end

end
