require 'vlad'

namespace :vlad do

  set :deploy_tasks, %w(
    vlad:update
    vlad:symlink
    vlad:bundle:install
    vlad:migrate
    vlad:start_app
    vlad:cleanup
  )

  desc "Full deployment cycle: #{deploy_tasks.join(', ')}"
  task "deploy" do
    deploy_tasks.each do |task|
      Rake::Task[task].invoke
    end
  end

end
