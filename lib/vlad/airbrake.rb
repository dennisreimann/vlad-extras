# encoding: utf-8
#
# Tasks:
#
#   - vlad:airbrake

namespace :vlad do

  desc 'Notify Airbrake for deployment'
  remote_task :airbrake do
    puts '[Airbrake] Notify'
    run "cd #{current_release}; nohup #{rake_cmd} airbrake:deploy RAILS_ENV=#{rails_env} TO=#{rails_env} REVISION=#{revision} USER=`whoami` REPO=#{repository} >> ./tmp/airbrake_notify&"
  end

end