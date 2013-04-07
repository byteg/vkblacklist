class GroupsChecker
  include Sidekiq::Worker

  def perform
  	Group.check_unbanned
  end
end