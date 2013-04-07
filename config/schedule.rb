env :PATH, ENV['PATH']

every 5.minutes do
  set :output, "/home/deploy/vkblacklist/shared/log/groups.log"
  rake "groups:check"
end
