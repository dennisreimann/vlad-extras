module VladExtras
  module Symlink
    # Create symlink unless file exists
    def self.remote_symlink(source, destination)
      run "test -f #{current_path}/#{destination} || ln -s #{shared_path}/#{source} #{current_path}/#{destination}"
    end
  end
end