# encoding: utf-8
#
# Tasks:
#
#   - vlad:deploy
#
# Example Configuration:
#
#   set :deploy_tasks, %w(
#     vlad:update
#     vlad:start_app
#     vlad:cleanup
#   )

require 'bundler/vlad'

namespace :vlad do

  set :deploy_tasks, %w(
    vlad:update
    vlad:bundle:install
    vlad:migrate
    vlad:start_app
    vlad:cleanup
  )

  desc "Full deployment cycle: #{deploy_tasks.map{ |t| t.gsub('vlad:','')}.join(', ')}"
  task :deploy do
    deploy_tasks.each do |task|
      Rake::Task[task].invoke
    end
  end

end
