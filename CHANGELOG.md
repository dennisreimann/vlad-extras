# CHANGELOG

## 0.7.1

* Improved variable bindings
* Sidekiq: Fixed restart task

## 0.7.0

* Sidekiq: Added recipe
* Custom permissions: Added recipe. Thanks @lemoinem
* RVM: Use :command_prefix to ensure that rvm will always be initialized if the RVM recipe is used. Thanks @lemoinem
* Update dependencies specs to allow the upmost versions of vlad and rake-remote_task. Thanks @lemoinem
* Uberspace: Added ssh shared connection limit hint. Thanks @erotte
* Symlinks: Mark symlinks.rb as obsolete, any call to it will put out a warning message. Thanks @lemoinem
* Fix on which host remote bd commands are applied. Thanks @lemoinem
