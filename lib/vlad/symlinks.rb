# encoding: utf-8
#
# Tasks:
#
#   - vlad:symlink
#
# Example Configuration:
#
#   set :symlinks, {
#     'assets'              => 'public/assets',
#     'config/database.yml' => 'config/database.yml'
#   }

require 'vlad-extras/symlink'

namespace :vlad do

  set :symlinks, {}

  desc 'Symlinks files and folders from shared directory to the current release'
  remote_task :symlink, :roles => :web do
    puts '[Symlink] Linking files'
    if symlinks.is_a? Hash
      symlinks.each_pair do |source, destination|
        VladExtras::Symlink.remote_symlink(source, destination)
      end
    else
      symlinks.each do |file|
        VladExtras::Symlink.remote_symlink(file, file)
      end
    end
  end

end