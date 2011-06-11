# -*- coding: utf-8 -*-
require 'vlad'

namespace :vlad do

  namespace :db do

    def prepare_psql(config)
      command=''
      command << "-h #{config['host']} " unless config['host'].blank?
      command << "-p #{config['port']} " unless config['port'].blank?
      command << "-U #{config['username']} " unless config['username'].blank?
      if config['password'].blank?
        command << "#{config['database']}"
      else
        command << "\"dbname=#{config['database']} password=#{config['password']}\""
      end
      command
    end

    desc "Clone the remote production database into the local development"
    task :clone => :environment do
      dev_config = ActiveRecord::Base.configurations['development']
      prod_config = ActiveRecord::Base.configurations['production']
      command = ""

      unless dev_config['adapter']==prod_config['adapter']
        puts "Development and production adapters must be similar (#{dev_config['adapter']}!=#{prod_config['adapter']})"
        exit
      end
      case dev_config['adapter']
        #
        # Sorry I don't use mysql
        #
        # mysqldump app_development | mysql app_test
        # when 'mysql'
        #   command << "mysql "
        #   command << "--host=#{config['host'] || 'localhost'} "
        #   command << "--port=#{config['port'] || 3306} "
        #   command << "--user=#{config['username'] || 'root'} "
        #   command << "--password=#{config['password'] || ''} "
        #   command << config['database']
      when 'postgresql'
        remote_command = "pg_dump " + prepare_psql(prod_config)
        local_command = "psql " + prepare_psql(dev_config)
      else
        puts "Unsupported database adapter: #{config['adapter']}"
      end
      command = "ssh #{domain} \"cd #{current_path}; #{remote_command}\" | #{local_command}"
      puts command
      system command
    end
  end
end
