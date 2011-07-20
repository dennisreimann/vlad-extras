require 'vlad'

namespace :vlad do
  
  namespace :delayed_job do 
    
    set :delayed_job_cmd, 'script/delayed_job'
    
    %w(start restart stop).each do |task|
      desc "#{task.capitalize} the delayed_job process"
      remote_task task.to_sym, :roles => :app do
        run "cd #{current_path}; RAILS_ENV=#{rails_env} #{delayed_job_cmd} #{task}"
      end
    end
  end
  
end
