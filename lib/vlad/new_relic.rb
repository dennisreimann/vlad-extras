# encoding: utf-8
#
# Tasks:
#
#   - vlad:new_relic

namespace :vlad do

  desc 'Notify NewRelic for deployment'
  remote_task :new_relic do
    puts '[NewRelic] Notify'
    run "cd #{current_release} && newrelic deployments -e #{rails_env} -r #{revision}"
  end

end