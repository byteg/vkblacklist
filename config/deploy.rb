# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'vkblacklist.ru'
set :repo_url, 'git@github.com:byteg/vkblacklist.git'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :deploy_to, '/home/deploy/vkblacklist'

set :linked_files, %w{config/database.yml config/newrelic.yml config/keys.yml}

role :app, %w{deploy@vkblacklist.ru}

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma-production.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma-production.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/production.socket"    #accept array for multi-bind
set :puma_conf, "#{release_path}/config/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [1, 16]
set :puma_workers, 1
set :puma_worker_timeout, nil
set :puma_preload_app, true
set :puma_init_active_record, true

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
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

  after :published, 'cw:restart' do
     puts "ReStarting clockwork"
     on roles(:app) do
       execute "cd #{current_path} && /usr/local/rvm/bin/rvm default do bundle exec clockworkd restart --log-dir=#{current_path}/log/ --pid-dir=#{current_path}/tmp/pids/ -l -c config/clock.rb", raise_on_non_zero_exit: false
       #execute "if [ -d #{current_path} ] && [ -f #{pid_file} ]; then cd #{current_path} && kill -INT `cat #{pid_file}` ; fi"
       #execute "--name=clockwork --env=production --output=#{current_path}/log/clockwork.log --pidfile=#{current_path}/tmp/pids/clockwork.pid -D #{current_path} -- bundle exec clockwork config/clock.rb"
       #execute "script/clockworkd run"
       #execute "RAILS_ENV=production clockworkd -c config/clock.rb start"
     end
  end
end

#after "deploy:stop",    "clockworkd:stop"
#after "deploy:start",   "clockworkd:start"
#after "deploy:restart", "clockworkd:restart"


#after "deploy:stop", "clockwork:stop"
#after "deploy:start", "clockwork:start"
#after "deploy:restart", "clockwork:restart"

#after "deploy:published", "cw_start"

 
# namespace :clockwork do
#   desc "Stop clockwork"
#   task :stop, :on_error => :continue, :on_no_matching_servers => :continue do
#     run "if [ -d #{current_path} ] && [ -f #{pid_file} ]; then cd #{current_path} && kill -INT `cat #{pid_file}` ; fi"
#   end
 
#   desc "Start clockwork"
#   task :start do
#     puts "Starting clockwork"
#     run "daemon --inherit --name=clockwork --env=production --output=#{current_path}/log/clockwork.log --pidfile=#{current_path}/tmp/pids/clockwork.pid -D #{current_path} -- bundle exec clockwork config/clock.rb"
#   end
 
#   desc "Restart clockwork"
#   task :restart, :on_no_matching_servers => :continue do
#     stop
#     start
#   end

# end