require 'vlad'

namespace :vlad do
  
  namespace :monit do
  
    set :monit_command, "/etc/init.d/monit"
    
    desc "Start monit"
    remote_task :start, :roles => :web  do
      run "#{monit_command} start"
    end
    
    desc "Stop monit"
    remote_task :stop, :roles => :web  do
      run "#{monit_command} stop"
    end
    
    desc "Restart monit"
    remote_task :restart, :roles => :web  do
      run "#{monit_command} restart"
    end
    
    desc "Reload monit config"
    remote_task :reload, :roles => :web  do
      run "#{monit_command} force-reload"
    end
    
    desc "Check monit config syntax"
    remote_task :syntax, :roles => :web  do
      run "#{monit_command} syntax"
    end
    
  end
  
end
