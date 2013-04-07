#require "../app/workers/groups_checker.rb"

require 'clockwork'
require 'sidekiq'

class GroupsChecker
  include Sidekiq::Worker
end

module Clockwork
  every(15.seconds, 'groups.check_unbanned') { GroupsChecker.perform_async }
end


