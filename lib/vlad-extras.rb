# Load default recipes
%w(assets copy db deploy setup symlinks).each do |recipe|
  require File.dirname(__FILE__) + "/vlad/#{recipe}.rb"
end