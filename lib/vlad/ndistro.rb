require 'vlad'

namespace :vlad do
  
  set :mkdirs, %w(tmp)
  set :shared_paths, { 'log' => 'log' }
  
  namespace :ndistro do
    
    set :ndistro_cmd, nil
    
    desc "Install ndistro"
    remote_task :setup, :roles => :app do
      bin_dir = File.join(shared_path, 'bin')
      run "mkdir -p #{bin_dir}"
      run "cd #{bin_dir} && curl http://github.com/visionmedia/ndistro/raw/master/install | sh"
    end
    
    desc "Install dependencies"
    remote_task :install_deps, :roles => :app do
      %w(bin lib modules).each do |dir|
        shared_dir_path = File.join(shared_path, dir)
        release_dir_path = File.join(current_release, dir)
        run "mkdir -p #{shared_dir_path}"
        run "ln -s #{shared_dir_path} #{release_dir_path}"
      end
      ndistro_cmd = Rake::RemoteTask.fetch(:ndistro_cmd, File.join(shared_path, 'bin', 'ndistro'))
      run "cd #{current_release} && #{ndistro_cmd}"
    end

    desc "Clean dependencies"
    remote_task :clean_deps, :roles => :app do
      %w(bin lib modules).each do |dir|
        shared_dir_path = File.join(shared_path, dir)
        run "rm -r #{shared_dir_path}"
      end
    end
  end
  
  desc "Full deployment cycle: Update, ndistro:install_deps, restart_app, cleanup"
  remote_task :deploy, :roles => :app do
    %w(update ndistro:install_deps restart_app cleanup).each do |task|
      Rake::Task["vlad:#{task}"].invoke
    end
  end
end
