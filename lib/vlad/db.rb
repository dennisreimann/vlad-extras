# encoding: utf-8
#
# Tasks:
#
#   - vlad:db:create
#   - vlad:db:setup
#   - vlad:db:seed
#   - vlad:db:rollback
#   - vlad:db:drop
#   - vlad:db:clone

namespace :vlad do

  namespace :db do

    desc 'Clone the remote database into the local database'
    task :clone => :environment do |t, args|
      puts "[Database] Cloning #{rails_env} into development database"
      # check adapters
      loc = ActiveRecord::Base.configurations['development']
      rem = ActiveRecord::Base.configurations[rails_env]
      adapter = loc['adapter'] == rem['adapter'] ? loc['adapter'] : nil
      raise "Development and #{rails_env} adapters must be similar" unless adapter
      # perform
      case adapter
      when 'mysql', 'mysql2'
        rem_cmd  = "mysqldump --add-drop-table #{VladExtras::Database.mysql_config(rem)}"
        loc_cmd = "mysql #{VladExtras::Database.mysql_config(loc)}"
      when 'postgresql'
        rem_cmd = "pg_dump -cxO #{VladExtras::Database.psql_config(rem)}"
        loc_cmd = "psql #{VladExtras::Database.psql_config(loc)}"
      else
        puts "Unsupported database adapter: #{adapter}"
      end
      system "ssh #{domain} \"cd #{current_path}; #{rem_cmd}\" | #{loc_cmd}"
    end

    %w(create drop rollback seed setup).each do |task|
      desc "#{task.capitalize} database"
      remote_task task.to_sym, :roles => :app do
        puts "[Database] #{task.capitalize} database"
        run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake_cmd} db:#{task}"
      end
    end
  end

end