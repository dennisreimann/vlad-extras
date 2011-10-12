# encoding: utf-8
require 'vlad'
require "vlad-extras/db_clone"

namespace :vlad do

  namespace :db do

    desc "Clone the remote database into the local database"
    task :clone => :environment do |t, args|
      puts "[DB Clone] Cloning #{rails_env} into development database"
      # Check adapters
      loc = ActiveRecord::Base.configurations['development']
      rem = ActiveRecord::Base.configurations[rails_env]
      adapter = loc['adapter'] == rem['adapter'] ? loc['adapter'] : nil
      raise "Development and #{rails_env} adapters must be similar" unless adapter
      # perform
      case adapter
      when 'mysql', 'mysql2'
        rem_cmd  = "mysqldump --add-drop-table #{VladExtras::DbClone.mysql_config(rem)}"
        loc_cmd = "mysql #{VladExtras::DbClone.mysql_config(loc)}"
      when 'postgresql'
        rem_cmd = "pg_dump -cxO #{VladExtras::DbClone.psql_config(rem)}"
        loc_cmd = "psql #{VladExtras::DbClone.psql_config(loc)}"
      else
        puts "Unsupported database adapter: #{adapter}"
      end
      system "ssh #{domain} \"cd #{current_path}; #{rem_cmd}\" | #{loc_cmd}"
    end

  end

end
