# -*- coding: utf-8 -*-
namespace :vlad do
  namespace :thinking_sphinx do
    remote_task :restart do
      run "cd #{current_path} && rake RAILS_ENV=#{rails_env} ts:restart"
    end
    remote_task :start do
      run "cd #{current_path} && rake RAILS_ENV=#{rails_env} ts:start"
    end
    remote_task :stop do
      run "cd #{current_path} && rake RAILS_ENV=#{rails_env} ts:stop"
    end
    remote_task :reindex do
      run "cd #{current_path} && rake RAILS_ENV=#{rails_env} ts:reindex"
    end
    remote_task :index do
      run "cd #{current_path} && rake RAILS_ENV=#{rails_env} ts:index"
    end
    remote_task :config do
      run "cd #{current_path} && rake RAILS_ENV=#{rails_env} ts:config"
    end
  end
end # End vlad namespace
