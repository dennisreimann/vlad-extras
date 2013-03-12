# encoding: utf-8
#
# Tasks:
#
#   - vlad:monit:start
#   - vlad:monit:restart
#   - vlad:monit:stop
#   - vlad:monit:reload
#   - vlad:monit:syntax
#
# Example Configuration:
#
#   set :monit_cmd, '/etc/init.d/monit'

namespace :vlad do

  namespace :monit do

    set(:monit_cmd) { '/etc/init.d/monit' }

    %w(start restart stop).each do |task|
      desc "#{task.capitalize} monit"
      remote_task task.to_sym, :roles => :app do
        puts "[Monit] #{task.capitalize}"
        sudo "#{monit_cmd} #{task}"
      end
    end

    desc 'Reload monit config'
    remote_task :reload, :roles => :web  do
      puts '[Monit] Reloading config'
      sudo "#{monit_cmd} force-reload"
    end

    desc 'Check monit config syntax'
    remote_task :syntax, :roles => :web  do
      puts '[Monit] Syntax check'
      sudo "#{monit_cmd} syntax"
    end

  end

end
