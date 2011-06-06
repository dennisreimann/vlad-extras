require 'vlad'

namespace :vlad do
  
  namespace :delayed_job do 
    
    set :delayed_job_cmd, 'script/delayed_job'
    set :dj_processes_count, nil 
    
    %w(start restart stop).each do |task|
      desc "#{task.capitalize} the delayed_job process"
      remote_task task.to_sym, :roles => :app do
        processes = dj_processes_count and task=~/start/ ? "-n #{dj_processes_count}" : ''
        run "cd #{current_path}; RAILS_ENV=#{rails_env} #{delayed_job_cmd} #{task} #{processes}"
      end
    end
  end
  
end
