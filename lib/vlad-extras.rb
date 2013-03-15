# helpers
require 'vlad-extras/database'
require 'vlad-extras/remote'

# set defaults
set :bundle_cmd, "bundle"

# load default recipes
# symlinks is now obsolete, use vlad:update_symlinks instead
%w(assets copy db deploy setup symlinks).each do |recipe|
  require File.dirname(__FILE__) + "/vlad/#{recipe}.rb"
end
