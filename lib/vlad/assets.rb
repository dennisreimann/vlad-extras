# encoding: utf-8
#
# Tasks:
#
#   - vlad:assets:clean
#   - vlad:assets:precompile
#   - vlad:assets:create_shared_dir

namespace :vlad do

  namespace :assets do

    %w(clean precompile).each do |task|
      desc "#{task.capitalize} assets"
      remote_task task.to_sym, :roles => :app do
        puts "[Assets] #{task.capitalize} assets"
        run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake_cmd} assets:#{task}"
      end
    end

    desc 'Creates the assets directory in shared path'
    remote_task :create_shared_dir, :roles => :app do
      puts "[Assets] Create shared/assets directory"
      run "mkdir -p #{shared_path}/assets"
    end

  end

end