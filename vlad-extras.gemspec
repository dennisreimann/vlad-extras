# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vlad-extras/version"

Gem::Specification.new do |s|
  s.name        = "vlad-extras"
  s.version     = VladExtras::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dennis Reimann", "Danil Pismenny"]
  s.email       = ["mail@dennisreimann.de"]
  s.homepage    = "http://rubygems.org/gems/vlad-extras"
  s.summary     = "Vlad plugin with extensions for Nginx, nodeJS, monit and more."
  s.description = "This gem provides extra recipes for Vlad the Deployer."

  s.add_development_dependency("vlad", ["~> 2.2.4"])

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = 'lib'
end