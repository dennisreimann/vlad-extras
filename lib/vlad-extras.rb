# Load extra recipes
%w(symlinks monit copy bundle rvm deploy delayed_job).each do |recipe|
  require File.dirname(__FILE__) + "/vlad/#{recipe}.rb"
end
