# encoding: utf-8
#
# Tasks:
#
#   - vlad:symlink
#
# THIS TASK IS OBSOLETE. vlad:update_symliks (invoked as part of vlad:update)
# SHOULD NOW BE USED INSTEAD!
#
# Example Configuration:
#
#   set :shared_paths, {
#     'assets'              => 'public/assets',
#     'config/database.yml' => 'config/database.yml'
#   }

namespace :vlad do

  set :symlinks, {}

  desc 'Symlinks files and folders from shared directory to the current
  release. THIS TASK IS OBSOLETE. vlad:update_symliks (invoked as part of
  vlad:update) SHOULD NOW BE USED INSTEAD!'.cleanup
  remote_task :symlink, :roles => :app do

    puts '[Symlink] THIS TASK IS OBSOLETE. vlad:update_symliks (invoked as part
  of vlad:update) SHOULD NOW BE USED INSTEAD!'.cleanup
    puts '[Symlink] Linking files'

    unless symlinks.is_a? Hash
      symlink_as_hash = {}
      symlinks.each { |f| symlink_as_hash[f] = f }
      symlinks = symlink_as_hash
    end

    set :shared_paths, symlinks
    Rake::Task['vlad::update_symlinkfs']
  end

end
