# Load extra recipes
%w(symlinks monit new_relic copy bundle rvm thinking_sphinx nginx deploy deploy db_clone hoptoad delayed_job).each do |recipe|
  require File.dirname(__FILE__) + "/vlad/#{recipe}.rb"
end

# http://blog.jayfields.com/2008/02/rake-task-overwriting.html
class Rake::Task
  def overwrite(&block)
    @actions.clear
    enhance(&block)
  end
end

# http://matthewbass.com/2007/03/07/overriding-existing-rake-tasks/
# http://rubyizednrailified.blogspot.com/2008/07/remove-rake-tasks.html
Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

