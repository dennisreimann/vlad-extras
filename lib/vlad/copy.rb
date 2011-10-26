# encoding: utf-8
require 'vlad'
require 'vlad-extras/copy'

namespace :vlad do

  namespace :copy do

    set :copy_files, {}
    set :copy_shared, {}

    desc "Copy files to remote"
    task :files do
      puts "Copying files to remote:"
      copy_files.each_pair do |local, remote|
        puts "#{local} -> #{remote}"
        VladExtras::Copy.local_to_remote(local, remote)
      end
    end

    desc "Copy files into remote shared directory"
    task :shared do
      puts "Copying files into remote shared directory:"
      copy_shared.each_pair do |local, remote|
        puts "#{local} -> shared/#{remote}"
        VladExtras::Copy.local_to_remote(local, "#{shared_path}/#{remote}")
      end
    end

  end

end
