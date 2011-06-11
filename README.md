# vlad-extras

Plugin for [Vlad the Deployer](http://rubyhitsquad.com/Vlad_the_Deployer.html) with extensions for Nginx, nodeJS, monit and more. The easiest way to use this gem is using Bundler and including it in your Gemfile:

    gem 'vlad', :git=>'git@github.com:dapi/vlad.git'
    gem 'vlad-extras', :git=>'git@github.com:dapi/vlad-extras.git'

## Using the recipes

By loading vlad-extras you get some extra recipes per default:

* Symlinks: Lets you set a symlinks hash and gives you a task that links files and folders from your shared directory to the current release.
* Monit: Control monit with start/stop/restart/reload/syntax tasks.

Other recipes can be used by defining them when you load Vlad, for example the :type and :web flavor:

* Nginx (:web) - Just some basic tasks for starting/stopping Nginx as your webserver.
* nodeJS (:type) - Tasks for managing your dependencies with [ndistro](http://github.com/visionmedia/ndistro) and starting/stopping your app with [spark](http://github.com/senchalabs/spark/).
* ThinkingShpinx control
* DelayedJob control
* Hoptoad notification
* NewRelic notification
* vlad:rvm:trust:current/repo/release Trusting rvmrc
* vlad:bundle Run bundle --deployment after deploy
* Support bundle exec rake
* vlad:copy Copy configuration files into shared (config/database.yml) for example
* vlad:db:clone Clone remote production database into local development
* vlad:deploy - configurable deploy tasks
* LoopDance support
* vlad:symlink - symlinking to files, copied with vlad:copy for example

Load them like this:

    Vlad.load(:web => :nginx, :type => :nodejs)

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Dennis Blöte. 2011 Danil Pismenny. See LICENSE for details.
