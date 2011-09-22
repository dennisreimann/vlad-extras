# -*- coding: utf-8 -*-
namespace :vlad do
  desc "Notify NewRelic for deployment"
  remote_task :new_relic do
    puts "Execute new_relice"
    run "cd #{current_release} && newrelic deployments -e #{rails_env} -r #{revision}"
  end
end # End vlad namespace
