module VladExtras
  module RemoteFile
    def self.exists?(full_path)
      run("test -f #{full_path} || echo 'false'").strip != 'false'
    end
  end
end