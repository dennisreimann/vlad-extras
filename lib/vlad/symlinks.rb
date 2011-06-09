require 'vlad'

namespace :vlad do

  set :symlinks, {}

  desc "Symlinks files"
  remote_task :symlink, :roles => :web do
    if symlinks.is_a? Hash
      symlinks.each_pair do |source, destination|
        run "ln -s #{shared_path}/#{source} #{current_path}/#{destination}"
      end
    else
      symlinks.each do |file|
        run "ln -s #{shared_path}/#{file} #{current_path}/#{file}"
      end
    end
  end

  remote_task :update do
    # Rake::Task['vlad:symlink'].invoke
    # Rake::Task['vlad:bundle_install'].invoke
    # Rake::Task['vlad:trust_scm_rvm'].invoke
  end

end
