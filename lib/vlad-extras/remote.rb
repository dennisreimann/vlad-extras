module VladExtras
  module Remote
    def self.exists?(path)
      out = "#{path} does not exist"
      run("test -e #{path} || echo '#{out}'").strip != out
    end

    def self.copy_local_to_remote(local, remote)
      dir = File.dirname(remote)
      `ssh #{domain} 'mkdir -p #{dir}'` if dir
      `scp -r #{local} #{domain}:#{remote}`
    end

    # Create symlink unless file exists
    def self.symlink(source, destination)
      src = "#{shared_path}/#{source}"
      dst = "#{current_path}/#{destination}"
      run "test -e #{dst} || ln -s #{src} #{dst}"
    end
  end
end