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
    
    # Accessing Rake::RemoteTask.roles requires domain to be set, we
    # just set it blank in here so that RemoteTask does not complain
    set :domain, ""
    
    Rake::RemoteTask.roles.keys.each do |role|
      desc "Write out #{role} server files."
      remote_task role.to_sym, :roles => role.to_sym do
        Vlad::Writer.write_role(role)
      end
    end
    
  end
  
end
