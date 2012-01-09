# encoding: utf-8
namespace :vlad do

  namespace :amon do

    %w(start restart stop status).each do |task|
      desc "#{task.capitalize} amon"
      remote_task task.to_sym, :roles => :app do
        puts "[Amon] #{task.capitalize}"
        sudo "service amond #{task}"
        sudo "service amon #{task}"
      end
    end

  end

end