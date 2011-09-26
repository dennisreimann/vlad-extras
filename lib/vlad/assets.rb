namespace :vlad do

  namespace :assets do
    desc "Precompile the assets"
    remote_task :precompile, :roles => :app do
      puts "[Assets] Precompiling assets"
      run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake_cmd} assets:precompile"
    end
  end

end