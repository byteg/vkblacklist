#require "../app/workers/groups_checker.rb"

require 'clockwork'
require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { :url => 'redis://localhost:6379', :namespace => 'vkblacklist' }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => 'redis://localhost:6379', :namespace => 'vkblacklist' }
end


class GroupsChecker
  include Sidekiq::Worker
end

module Clockwork
  every(15.seconds, 'groups.check_unbanned') { GroupsChecker.perform_async }
end


