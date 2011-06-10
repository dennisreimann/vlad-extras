# -*- coding: utf-8 -*-
require 'vlad'

namespace :vlad do

  def symlink(source, destination)
    # Create symlink unless file exists
    run "test -f #{current_path}/#{destination} || ln -s #{shared_path}/#{source} #{current_path}/#{destination}"
  end


  set :symlinks, {}

  desc "Symlinks files"
  remote_task :symlink, :roles => :web do
    if symlinks.is_a? Hash
      symlinks.each_pair do |source, destination|
        symlink(source, destination)
      end
    else
      symlinks.each do |file|
        symlink(file, file)
      end
    end
  end


  # Не работает потому что remote
  # Rake::Task["vlad:update_symlinks"].enhance do
  #   Rake::Task['vlad:symlink'].invoke
  # end

end
