class UnbanNotifier
  include Sidekiq::Worker

  def perform(group_id, account_id)
  	g = Group.find group_id
  	a = Account.find account_id

  	RestClient.post a.unban_url, :group => a.item_id
  end
end