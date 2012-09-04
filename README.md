# vlad-extras

Plugin for [Vlad the Deployer](http://rubyhitsquad.com/Vlad_the_Deployer.html)
with extensions for Nginx, RVM, Airbrake, Monit and more.

## Setup

The easiest way to use this gem is using Bundler and including it in your Gemfile:

    gem 'vlad', :require => false
    gem 'vlad-extras', :require => false

Then, require the gems in your Rakefile like this:

    begin
      require 'vlad'
      require 'vlad-extras'
      Vlad.load # takes an options hash depending on your setup
    rescue LoadError
      puts 'Could not load Vlad'
    end

## Using the recipes

By loading vlad-extras you get the following default extra recipes:

  *   [Copy](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/copy.rb):
      Copies files and directories to the remote server via scp.

  *   [Deploy](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/deploy.rb):
      A more flexible way to define the tasks for a full deployment cycle

  *   [Symlinks](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/symlinks.rb):
      Lets you set a symlinks hash and gives you a task that links files and folders from your
      shared directory to the current release.

  *   [Assets](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/assets.rb):
      Tasks for cleaning and precompiling the assets.

  *   [Database](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/db.rb):
      The standard Rails database tasks plus cloning the remote database into the local database.

Other recipes can be used by defining them when you load Vlad (note that the name of the key does
not matter, for the extra recipes it is more like a description, the value is the recipe file name):

    Vlad.load(:web => :nginx, :monitoring => :monit, :queue => :delayed_job)

Or you can simply require the files inside your deploy.rb (the load call basically does the same):

    require 'vlad/monit'
    require 'vlad/delayed_job'

An overview of the recipes incuded in this gem:

  *   [Nginx](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/nginx.rb):
      Basic tasks for starting/stopping. Add it like this:

  *   [RVM](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/rvm.rb):
      Wrapper tasks for `rvm rvmrc trust`

  *   [Monit](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/monit.rb):
      Basic control tasks.

  *   [ThinkingSphinx](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/thinking_sphinx.rb):
      Basic control tasks.

  *   [DelayedJob](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/delayed_job.rb):
      Basic control tasks.

  *   [Airbrake](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/airbrake.rb):
      Task for notifying [Airbrake](https://www.airbrake.io) after the deployment.

  *   [NewRelic](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/new_relic.rb):
      Task for notifying [NewRelic](http://newrelic.com/) after the deployment.

  *   [LoopDance](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/loop_dance.rb):
      Task to restart [loop dancers](http://rubygems.org/gems/loop_dance).

  *   [Whenever](https://github.com/dennisreimann/vlad-extras/blob/master/lib/vlad/whenever.rb):
      Update and clear the crontab using [whenever](http://rubygems.org/gems/whenever).

## Note on Patches/Pull Requests

  * Fork the project.
  * Make your feature addition or bug fix.
  * Commit, do not mess with Rakefile, Gemspec or version.
    (if you want to have your own version that is fine, but bump version in a
    commit by itself so it can be ignored when pulling in the other changes)
  * Send a pull request.

## Contributors

  * Danil Pismenny

## Copyright

Copyright (c) 2010-2012 Dennis Reimann.
See LICENSE for details.