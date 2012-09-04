# encoding: utf-8
#
# Tasks:
#
#   - vlad:delayed_job:start
#   - vlad:delayed_job:restart
#   - vlad:delayed_job:stop
#
# Example Configuration:
#
#   set :delayed_job_cmd, 'script/delayed_job'
#   set :dj_processes_count, 2

namespace :vlad do

  namespace :delayed_job do

    set :delayed_job_cmd, 'script/delayed_job'
    set :dj_processes_count, nil

    %w(start restart stop).each do |task|
      desc "#{task.capitalize} the delayed_job process(es)"
      remote_task task.to_sym, :roles => :app do
        processes = dj_processes_count and task=~/start/ ? "-n #{dj_processes_count}" : ''
        puts "[Delayed Job] #{task.capitalize}"
        run "cd #{current_path} && RAILS_ENV=#{rails_env} #{delayed_job_cmd} #{task} #{processes}"
      end
    end
  end

end