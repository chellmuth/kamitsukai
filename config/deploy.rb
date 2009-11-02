require File.join(File.dirname(__FILE__), 'capistrano_database')
require File.join(File.dirname(__FILE__), 'capistrano_newrelic')

set :application, 'kamitsukai'
set :repository,  'git@github.com:jhelwig/kamitsukai.git'
set :scm,         :git
set :user,        'app'
set :use_sudo,    false

role :web, 'kamitsukai.perlninja.com'                   # Your HTTP server, Apache/etc
role :app, 'kamitsukai.perlninja.com'                   # This may be the same as your `Web` server
role :db,  'kamitsukai.perlninja.com', :primary => true # This is where Rails migrations will run
#role :db,  'your slave db-server here'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :branch, 'master'
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

task :after_update_code, :roles => :app do
  # Rebuild the gem native extensions, unless we explicitly say not to.
  unless ENV['BUILD_GEMS'] and ENV['BUILD_GEMS'] == '0'
    run "rake -f #{release_path}/Rakefile gems:build RAILS_ENV=production"
  end

  # Generate the CSS files using MORE & LESS
  run "rake -f #{release_path}/Rakefile more:parse RAILS_ENV=production"
end

desc 'Deploy the seed data to the database.'
task 'deploy:database:seed' do
  run "rake -f #{release_path}/Rakefile db:seed RAILS_ENV=production"
end

after 'deploy:migrate', 'deploy:database:seed'

namespace :deploy do
  task :start do
  end
  task :stop do
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
