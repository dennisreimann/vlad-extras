require 'vlad'

namespace :vlad do

  namespace :loop_dance do
  desc "Restart dancers"
   remote_task :restart do
     puts "Restart dancers #{current_release}"
     run "cd #{current_release}; RAILS_ENV=production rake loop_dance:dancer:restart"
    end
  end
end
