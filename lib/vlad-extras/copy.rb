module VladExtras
  module Copy
    def self.local_to_remote(local, remote)
      dir = File.dirname(remote)
      `ssh #{domain} 'mkdir -p #{dir}'` if dir
      `scp -r #{local} #{domain}:#{remote}`
    end
  end
end
