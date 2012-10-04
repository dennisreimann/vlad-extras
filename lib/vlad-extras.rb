# helpers
require 'vlad-extras/database'
require 'vlad-extras/remote'

%w(assets copy db deploy setup custom_permissions).each do |recipe|
  require File.dirname(__FILE__) + "/vlad/#{recipe}.rb"
end
