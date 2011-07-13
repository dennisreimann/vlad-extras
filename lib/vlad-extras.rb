# Load extra recipes
%w(symlinks monit writer delayed_job).each do |recipe|
  require File.dirname(__FILE__) + "/vlad/#{recipe}.rb"
end
