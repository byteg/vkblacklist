class BanNotifier
  include Sidekiq::Worker

  def perform(group_id)
  	g = Group.find group_id
  	a = Account.find account_id

  	RestClient.post a.ban_url, :group => a.item_id
  end
end