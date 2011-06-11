# -*- coding: utf-8 -*-
require 'vlad'

namespace :vlad do

  set :rake_cmd, 'bundle exec rake'

  namespace :bundle do
    set :bundle_without, "development test"

    desc "Execute bundle --deployment" #
    remote_task :install=>['vlad:rvm:trust:release', 'vlad:rvm:trust:current'] do
      # run bundle install with explicit path and without test dependencies
      # С release_path не работает текущая git версия
      run "cd #{current_path}; bundle install --deployment --without #{bundle_without}"
    end
  end
end
