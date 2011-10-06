# encoding: utf-8
require 'vlad'

namespace :vlad do

  namespace :monit do

    set :monit_cmd, "/etc/init.d/monit"

    %w(start restart stop).each do |task|
      desc "#{task.capitalize} monit"
      remote_task task.to_sym, :roles => :app do
        puts "[Monit] #{task.capitalize}"
        run "#{monit_cmd} #{task}"
      end
    end

    desc "Reload monit config"
    remote_task :reload, :roles => :web  do
      puts "[Monit] Reloading config"
      sudo "#{monit_cmd} force-reload"
    end

    desc "Check monit config syntax"
    remote_task :syntax, :roles => :web  do
      puts "[Monit] Syntax check"
      sudo "#{monit_cmd} syntax"
    end

  end

end
