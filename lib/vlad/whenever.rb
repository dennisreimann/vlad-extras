# encoding: utf-8
namespace :vlad do

  namespace :whenever do
    set :whenever_command,      "#{bundle_cmd} whenever"
    set :whenever_identifier,   application
    set :whenever_environment,  rails_env
    set :whenever_variables,    "environment=#{whenever_environment}"
    set :whenever_update_flags, "--update-crontab #{whenever_identifier} --set #{whenever_variables}"
    set :whenever_clear_flags,  "--clear-crontab #{whenever_identifier}"

    desc <<-DESC
      Update application's crontab entries using Whenever. You can configure \
      the command used to invoke Whenever by setting the :whenever_command \
      variable, which can be used with Bundler to set the command to \
      "bundle exec whenever". You can configure the identifier used by setting \
      the :whenever_identifier variable, which defaults to the same value configured \
      for the :application variable. You can configure the environment by setting \
      the :whenever_environment variable, which defaults to the same value \
      configured for the :rails_env variable which itself defaults to "production". \
      Finally, you can completely override all arguments to the Whenever command \
      by setting the :whenever_update_flags variable. Additionally you can configure \
      which servers the crontab is updated on by setting the :whenever_roles variable.
    DESC
    remote_task :update_crontab, :roles => :app do
      puts "[Whenever] Update crontab"
      run "cd #{current_path} && #{whenever_command} #{whenever_update_flags}"
    end

    desc <<-DESC
      Clear application's crontab entries using Whenever. You can configure \
      the command used to invoke Whenever by setting the :whenever_command \
      variable, which can be used with Bundler to set the command to \
      "bundle exec whenever". You can configure the identifier used by setting \
      the :whenever_identifier variable, which defaults to the same value configured \
      for the :application variable. Finally, you can completely override all \
      arguments to the Whenever command by setting the :whenever_clear_flags variable. \
      Additionally you can configure which servers the crontab is cleared on by setting \
      the :whenever_roles variable.
    DESC
    remote_task :clear_crontab, :roles => :app do
      puts "[Whenever] Clear crontab"
      run "cd #{latest_release} && #{whenever_command} #{whenever_clear_flags}"
    end

  end

end