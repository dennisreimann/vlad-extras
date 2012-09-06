# encoding: utf-8
#
# Tasks:
#
#   - vlad:copy:files  # from project directory to absolute path on the server
#   - vlad:copy:shared # from project directory to the projects shared path
#
# Example Configuration:
#
#   set :copy_files,  { 'config/server/nginx.conf' => '/opt/nginx/conf/nginx.conf'}
#   set :copy_shared, { 'config/database.yml' => 'config/database.yml' }

namespace :vlad do

  namespace :copy do

    set :copy_files, {}
    set :copy_shared, {}

    desc 'Copy files to remote'
    task :files do
      puts 'Copying files to remote:'
      copy_files.each_pair do |local, remote|
        puts "#{local} -> #{remote}"
        VladExtras::Remote.copy_local_to_remote(local, remote)
      end
    end

    desc 'Copy files into remote shared directory'
    task :shared do
      puts 'Copying files into remote shared directory:'
      copy_shared.each_pair do |local, remote|
        puts "#{local} -> shared/#{remote}"
        VladExtras::Remote.copy_local_to_remote(local, "#{shared_path}/#{remote}")
      end
    end

  end

end