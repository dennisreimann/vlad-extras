require 'vlad'

class Vlad::Writer
  
  set :writer_path, "config/server"
  
  def self.write_role(role)
    files = files_for_role(role)
    abort "Please specify at least one file to write for the role #{role}" if files.empty?
    
    role_path = path_for_role(role)
    files.each do |file|
      target = file.gsub(role_path, '')
      put target do
        File.readlines(file).map {|l| l}.join("\n")
      end
    end
  end
  
  def self.files_for_role(role)
    files = Dir["#{path_for_role(role)}/**/*"]
    files.reject { |f| File.directory?(f) || File.basename(f)[0] == ?. }
  end
  
  private
  
  def self.path_for_role(role)
    "#{writer_path}/#{role}"
  end
  
end

namespace :vlad do
  
  namespace :writer do
    
    desc "Write out all files to the appropriate roles."
    remote_task :all do
      Rake::RemoteTask.roles.keys.each do |role|
        Vlad::Writer.write_role(role) unless Vlad::Writer.files_for_role(role).empty?
      end
    end
    
    desc "Write out files to the app server."
    remote_task :app do
      Vlad::Writer.write_role("app")
    end
    
    desc "Write out files to the db server."
    remote_task :db do
      Vlad::Writer.write_role("db")
    end
    
    desc "Write out files to the web server."
    remote_task :web do
      Vlad::Writer.write_role("web")
    end
    
  end
  
end
