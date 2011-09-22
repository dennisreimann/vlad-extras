# -*- coding: utf-8 -*-
require 'vlad'

namespace :vlad do

  def remote_symlink(source, destination)
    # Create symlink unless file exists
    run "test -f #{current_path}/#{destination} || ln -s #{shared_path}/#{source} #{current_path}/#{destination}"
  end

  set :symlinks, {}

  desc "Symlinks files (usualy shared)"
  remote_task :symlink, :roles => :web do
    puts "[Symlink] Linking files"
    if symlinks.is_a? Hash
      symlinks.each_pair do |source, destination|
        remote_symlink(source, destination)
      end
    else
      symlinks.each do |file|
        remote_symlink(file, file)
      end
    end
  end
end