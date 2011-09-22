# -*- coding: utf-8 -*-
require 'vlad'

namespace :vlad do

  set :copy_files, []

  desc "Copy selected files into remote shared directory"
  task :copy do
    print "Copying files to server: "
    copy_files.each do |file|
      print "#{file}, "
      dir = File.dirname(file)
      `ssh #{domain} 'mkdir -p #{shared_path}/#{dir}'` if dir
      cmd = "scp -r #{file} #{domain}:#{shared_path}/#{file}"
      puts cmd
      `#{cmd}`
    end
    puts "Done"
  end

  task :setup do
    Rake::Task['vlad:copy'].invoke
  end
end
