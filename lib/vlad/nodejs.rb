require 'vlad/spark'
require 'vlad/ndistro'

namespace :vlad do

  set :mkdirs, %w(tmp)
  set :shared_paths, { 'log' => 'log' }

end