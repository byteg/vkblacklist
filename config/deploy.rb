require "bundler/capistrano"
require 'sidekiq/capistrano'

load 'deploy/assets'

set :application, "vkblacklist"
set :repository,  "git@github.com:byteg/vkblacklist.git"

set :branch, fetch(:branch, "master")

set :deploy_to, "/home/deploy/#{application}"
set :user, 'deploy'
set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "vkblacklist.ru"                          # Your HTTP server, Apache/etc
role :app, "vkblacklist.ru"                          # This may be the same as your `Web` server
role :db,  "vkblacklist.ru", :primary => true # This is where Rails migrations will run


before "deploy:finalize_update", "deploy:symlink_db_config"
after "deploy", "deploy:migrate"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :symlink_db_config do
     run "ln -sf #{shared_path}/config/* #{latest_release}/config/"
     run "ln -sf #{shared_path}/config/robots.txt #{latest_release}/public/robots.txt"
   end

   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end


after "deploy:stop", "clockwork:stop"
after "deploy:start", "clockwork:start"
after "deploy:restart", "clockwork:restart"
 
namespace :clockwork do
  desc "Stop clockwork"
  task :stop, :on_error => :continue, :on_no_matching_servers => :continue do
    run "if [ -d #{current_path} ] && [ -f #{pid_file} ]; then cd #{current_path} && kill -INT `cat #{pid_file}` ; fi"
  end
 
  desc "Start clockwork"
  task :start, :on_no_matching_servers => :continue do
    run "daemon --inherit --name=clockwork --env='#{rails_env}' --output=#{log_file} --pidfile=#{pid_file} -D #{current_path} -- bundle exec clockwork config/clock.rb"
  end
 
  desc "Restart clockwork"
  task :restart, :on_no_matching_servers => :continue do
    stop
    start
  end
 
  def rails_env
    fetch(:rails_env, false) ? "RAILS_ENV=#{fetch(:rails_env)}" : ''
  end
 
  def log_file
    fetch(:clockwork_log_file, "#{current_path}/log/clockwork.log")
  end
 
  def pid_file
    fetch(:clockwork_pid_file, "#{current_path}/tmp/pids/clockwork.pid")
  end
end