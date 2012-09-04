# encoding: utf-8
#
# Tasks:
#
#   - vlad:thinking_sphinx:start
#   - vlad:thinking_sphinx:restart
#   - vlad:thinking_sphinx:stop
#   - vlad:thinking_sphinx:index
#   - vlad:thinking_sphinx:reindex
#   - vlad:thinking_sphinx:config

namespace :vlad do

  namespace :thinking_sphinx do

    %w(start restart stop index reindex config).each do |task|
      desc "[Thinking Sphinx] #{task.capitalize}"
      remote_task task.to_sym, :roles => :app do
        run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake_cmd} ts:#{task}"
      end
    end

  end

end