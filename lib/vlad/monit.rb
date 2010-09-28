require 'vlad'

namespace :vlad do
  
  namespace :monit do
  
    set :monit_cmd, "/etc/init.d/monit"
    
    desc "Start monit"
    remote_task :start, :roles => :web  do
      sudo "#{monit_cmd} start"
    end
    
    desc "Stop monit"
    remote_task :stop, :roles => :web  do
      sudo "#{monit_cmd} stop"
    end
    
    desc "Restart monit"
    remote_task :restart, :roles => :web  do
      sudo "#{monit_cmd} restart"
    end
    
    desc "Reload monit config"
    remote_task :reload, :roles => :web  do
      sudo "#{monit_cmd} force-reload"
    end
    
    desc "Check monit config syntax"
    remote_task :syntax, :roles => :web  do
      sudo "#{monit_cmd} syntax"
    end
    
  end
  
end
