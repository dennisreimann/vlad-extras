# -*- coding: utf-8 -*-
namespace :vlad do

  desc "Notify NewRelic for deployment"
  remote_task :new_relic do
    puts "[NewRelic] Notify"
    run "cd #{current_release} && newrelic deployments -e #{rails_env} -r #{revision}"
  end

end