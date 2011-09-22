require 'vlad'

namespace :vlad do

  namespace :rvm do

    namespace :trust do
    desc "Trust scm/repo"
    remote_task :scm_repo do
      run "rvm rvmrc trust #{scm_path}/repo"
    end

    desc "Trust current "
    # Run after symlink creation
    remote_task :current do
      run "rvm rvmrc trust #{current_path}"
    end

    desc "Trust release"
    # Run after symlink creation
    remote_task :release do
      run "rvm rvmrc trust #{release_path}"
    end
    end
    # set :rvm_path, "/usr/local/rvm"

    # desc "Initializes the RVM environment"
    # task :init do
    #   run "source #{rvm_path}/scripts/rvm"
    # end

    # namespace :rvmrc do
    #  desc "Trusts the .rvmrc in the current release path"
    #   task :trust do
    #     run "rvm rvmrc trust #{current_release}"
    #   end

    #   desc "Changes to the release path so that the .rvmrc gets loaded"
    #   task :load do
    #     run "cd #{release_path}"
    #   end
    # end

  end

  # Rake::Task["vlad:setup"].enhance do
  #   puts 'scm'
  #   puts scm_path

  #    Rake::Task['vlad:rvm:trust_repo'].invoke
  # end
end
