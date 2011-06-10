require 'vlad'

namespace :vlad do

  desc "Full deployment cycle"
  task "deploy" => %w[
      vlad:update
      vlad:symlink_release
      vlad:symlink
      vlad:bundle:install
      vlad:migrate
      vlad:start_app
      vlad:cleanup
    ]

end
#      vlad:hoptoad

# remote_task :update do
#     Rake::Task['vlad:symlink'].invoke
#     # Rake::Task['vlad:bundle_install'].invoke
#     # Rake::Task['vlad:trust_scm_rvm'].invoke
#   end

