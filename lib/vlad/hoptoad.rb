# -*- coding: utf-8 -*-
namespace :vlad do
  desc "Notify Hoptoad for deployment"
  remote_task :hoptoad do
    puts "[Hoptoad] Notify"
    run "cd #{current_release}; nohup rake hoptoad:deploy RAILS_ENV=#{rails_env} TO=#{rails_env} REVISION=#{revision} USER=`whoami` REPO=#{repository} >> ./tmp/hoptoad_notify&"
  end
end