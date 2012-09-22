# encoding: utf-8
#
# Tasks:
#
#   - vlad:rvm:trust:scm_repo
#   - vlad:rvm:trust:current   # run after update
#   - vlad:rvm:trust:release   # run after update

namespace :vlad do

  namespace :rvm do

    namespace :trust do
      desc 'Trust scm/repo'
      remote_task :scm_repo do
        puts '[RVM] Trust scm/repo'
        run "rvm rvmrc trust #{scm_path}/repo"
      end

      desc 'Trust current (run after update)'
      remote_task :current do
        puts '[RVM] Trust current'
        run "rvm rvmrc trust #{current_path}"
      end

      desc 'Trust release (run after update)'
      remote_task :release do
        puts '[RVM] Trust release'
        run "rvm rvmrc trust #{release_path}"
      end
    end

  end

end
