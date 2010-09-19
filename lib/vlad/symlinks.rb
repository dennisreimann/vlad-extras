require 'vlad'

namespace :vlad do
  
  set :symlinks, {}
  
  desc "Symlinks files"
  remote_task :symlink, :roles => :web do
    symlinks.each_pair do |source, destination|
      run "ln -s #{shared_path}/#{source} #{current_path}/#{destination}"
    end
  end
end