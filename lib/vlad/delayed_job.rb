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
  
  desc "Full deployment cycle: Update, install bundle, migrate, restart, cleanup"
  remote_task :deploy, :roles => :app do
    %w(update symlink bundle:install migrate delayed_job:restart start_app cleanup).each do |task|
      Rake::Task["vlad:#{task}"].invoke
    end
  end
end
