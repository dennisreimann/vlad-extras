# encoding: utf-8
namespace :vlad do

  namespace :assets do
    
    %w(clean precompile).each do |task|
      desc "#{task.capitalize} assets"
      remote_task task.to_sym, :roles => :app do
        puts "[Assets] #{task.capitalize} assets"
        run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake_cmd} assets:#{task}"
      end
    end
    
  end

end