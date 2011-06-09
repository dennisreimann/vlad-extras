require 'vlad'

namespace :vlad do

  namespace :rvm do

    set :rvm_path, "/usr/local/rvm"

    desc "Initializes the RVM environment"
    task :init do
      run "source #{rvm_path}/scripts/rvm"
    end

    namespace :rvmrc do
     desc "Trusts the .rvmrc in the current release path"
      task :trust do
        run "rvm rvmrc trust #{current_release}"
      end

      desc "Changes to the release path so that the .rvmrc gets loaded"
      task :load do
        run "cd #{release_path}"
      end
    end

  end

end
