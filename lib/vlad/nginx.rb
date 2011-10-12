# encoding: utf-8
require 'vlad'

namespace :vlad do

  set :web_command, "/etc/init.d/nginx"

  %w(start restart stop).each do |task|
    desc "#{task.capitalize} the web server"
    remote_task "#{task}_web".to_sym, :roles => :web do
      puts "[Nginx] #{task.capitalize}"
      sudo "#{web_command} #{task}"
    end
  end

  %w(start stop).each do |task|
    desc "#{task.capitalize} the web and app servers"
    remote_task task.to_sym do
      Rake::Task["vlad:#{task}_app"].invoke
      Rake::Task["vlad:#{task}_web"].invoke
    end
  end

end
