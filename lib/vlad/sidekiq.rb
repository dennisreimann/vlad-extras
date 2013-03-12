# encoding: utf-8
#
# Heavily inspired by
# https://github.com/mperham/sidekiq/blob/master/lib/sidekiq/capistrano.rb
#
# Tasks:
#
#   - vlad:sidekiq:quiet
#   - vlad:sidekiq:start
#   - vlad:sidekiq:stop
#   - vlad:sidekiq:restart
#
# Example Configuration:
#
#   set :sidekiq_env,    'production'
#   set :sidekiq_cmd,    'bundle exec sidekiq'
#   set :sidekiqctl_cmd, 'bundle exec sidekiqctl'

namespace :vlad do

  namespace :sidekiq do

    set :sidekiq_cmd,       "#{bundle_cmd} exec sidekiq"
    set :sidekiqctl_cmd,    "#{bundle_cmd} exec sidekiqctl"
    set :sidekiq_pid,       "#{current_path}/tmp/pids/sidekiq.pid"
    set :sidekiq_env,       "production"
    set :sidekiq_processes, 1
    set :sidekiq_timeout,   10

    def for_each_process(&block)
      sidekiq_processes.times do |idx|
        yield((idx == 0 ? sidekiq_pid : "#{sidekiq_pid}-#{idx}"), idx)
      end
    end

    desc "Quiet sidekiq (stop accepting new work)"
    remote_task :quiet, :roles => :app do
      puts "[Sidekiq] Quiet"
      for_each_process do |pid_file, idx|
        run "if [ -d #{current_path} ] && [ -f #{pid_file} ] && kill -0 `cat #{pid_file}`> /dev/null 2>&1; then cd #{current_path} && #{sidekiqctl_cmd} quiet #{pid_file} ; else echo 'Sidekiq is not running'; fi"
      end
    end

    desc "Stop sidekiq"
    remote_task :stop, :roles => :app do
      puts "[Sidekiq] Stop"
      for_each_process do |pid_file, idx|
        run "if [ -d #{current_path} ] && [ -f #{pid_file} ] && kill -0 `cat #{pid_file}`> /dev/null 2>&1; then cd #{current_path} && #{sidekiqctl_cmd} stop #{pid_file} #{sidekiq_timeout} ; else echo 'Sidekiq is not running'; fi"
      end
    end

    desc "Start sidekiq"
    remote_task :start, :roles => :app do
      puts "[Sidekiq] Start"
      for_each_process do |pid_file, idx|
        run "cd #{current_path} ; nohup #{sidekiq_cmd} -e #{sidekiq_env} -C #{current_path}/config/sidekiq.yml -i #{idx} -P #{pid_file} >> #{current_path}/log/sidekiq.log 2>&1 &", :pty => false
      end
    end

    desc "Restart sidekiq"
    remote_task :restart, :roles => :app do
      Rake::Task["vlad:sidekiq:stop"].invoke
      Rake::Task["vlad:sidekiq:start"].invoke
    end

  end

end
