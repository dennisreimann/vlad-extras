# -*- coding: utf-8 -*-
require 'vlad'

namespace :vlad do

  set :copy, {}

  desc "Copy fiels"
  task :copy do
    print "Copying files to server: "
    copy.each do |file|
      dir = File.dirname(file)
      `ssh #{domain} "mkdir -p #{shared_path}/#{dir}"` if dir
      print "#{file}, "
      `scp -r #{file} #{domain}:#{shared_path}/#{file}`
    end
    puts ". Done"
  end

  task :setup do
    Rake::Task['vlad:copy'].invoke
  end
end
