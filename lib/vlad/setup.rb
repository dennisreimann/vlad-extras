# encoding: utf-8
#
# Tasks:
#
#   - vlad:setup
#
# Example Configuration:
#
#   set :setup_tasks, %w(
#     vlad:setup_app
#     vlad:copy:files
#     vlad:assets:create_shared_dir
#   )

namespace :vlad do

  set :setup_tasks, %w(
    vlad:setup_app
  )

  task :setup do
    setup_tasks.each do |task|
      Rake::Task[task].invoke
    end
  end

end