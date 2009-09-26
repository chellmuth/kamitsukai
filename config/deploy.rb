require File.join(File.dirname(__FILE__), 'capistrano_database')

set :application, "kamitsukai"
set :repository,  "git@github.com:jhelwig/kamitsukai.git"

set :scm, :git

role :web, "kamitsukai.perlninja.com"                          # Your HTTP server, Apache/etc
role :app, "kamitsukai.perlninja.com"                          # This may be the same as your `Web` server
role :db,  "kamitsukai.perlninja.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start {}
#   task :stop {}
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
