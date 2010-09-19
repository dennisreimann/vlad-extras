require 'vlad'

namespace :vlad do
  
  set :spark_env, "production"
  set :spark_config, "config.js"
  set :spark_workers, 1
  set :spark_cmd, nil
  set :spark_host, nil
  set :spark_port, nil
  set :spark_user, nil
  set :spark_group, nil
  
  desc "Start the app"
  remote_task :start_app, :roles => :app do
    log_path = File.join(shared_path, 'log', "#{spark_env}.log")
    cfg_path = File.join(current_release, spark_config)
    spark_cmd = Rake::RemoteTask.fetch(:spark_cmd, File.join(shared_path, 'bin', 'spark'))
    opts = []
    if File.file?(cfg_path)
      opts << "-c #{cfg_path}"
    else
      opts << "-E #{spark_env}"
      opts << "-n #{spark_workers}" unless spark_workers.nil?
      opts << "-H #{spark_host}"    unless spark_host.nil?
      opts << "-p #{spark_port}"    unless spark_host.nil?
      opts << "-u #{spark_user}"    unless spark_user.nil?
      opts << "-g #{spark_group}"   unless spark_group.nil?
    end
    run "#{spark_cmd} --comment sparked_#{application} #{opts.join(" ")} >> #{log_path} 2>&1"
  end
  
  desc "Stop the app"
  remote_task :stop_app, :roles => :app do
    run "ps ax | grep '\--comment sparked_#{application}' | grep -v grep | awk '{print $1}'"
  end
  
  desc "Restart the app"
  remote_task :restart_app, :roles => :app do
    %w(stop_app start_app).each do |task|
      Rake::Task["vlad:#{task}"].invoke
    end
  end
end
