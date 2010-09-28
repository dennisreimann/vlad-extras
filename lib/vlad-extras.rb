# Load extra recipes
%w(symlinks monit).each do |recipe|
  require File.dirname(__FILE__) + "/vlad/#{recipe}.rb"
end
