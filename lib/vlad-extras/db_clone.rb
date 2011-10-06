module VladExtras
  module DbClone
    def self.mysql_config(config)
      cmd  = " "
      cmd += "-h #{config['host']} " unless config['host'].blank?
      cmd += "-P #{config['port']} " unless config['port'].blank?
      cmd += "-u #{config['username']} " unless config['username'].blank?
      cmd += "-p#{config['password']} " unless config['password'].blank?
      cmd += config['database']
      cmd
    end
    
    def self.psql_config(config)
      cmd  = " "
      cmd += "-h #{config['host']} " unless config['host'].blank?
      cmd += "-p #{config['port']} " unless config['port'].blank?
      cmd += "-U #{config['username']} " unless config['username'].blank?
      cmd += config['password'].blank? ? "#{config['database']}" : "'dbname=#{config['database']} password=#{config['password']}'"
      cmd
    end
  end
end
