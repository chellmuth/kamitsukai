#
# = Capistrano newrelic.yml task
#
# Provides a couple of tasks for creating the newrelic.yml
# configuration file dynamically when deploy:setup is run.
#
# Category::    Capistrano
# Package::     Database
# Author::      Simone Carletti
# Copyright::   2007-2009 The Authors
# License::     MIT License
# Link::        http://www.simonecarletti.com/
# Source::      http://gist.github.com/2769
#
#

unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end

Capistrano::Configuration.instance.load do
  namespace :setup do
    desc <<-DESC
      [internal] Updates the symlink for newrelic.yml file to the just deployed release.
    DESC
    task :newrelic, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    end
  end

  after "deploy:finalize_update", "setup:newrelic"
end
