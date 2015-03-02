class BanNotifier
  include Sidekiq::Worker

  def perform(group_id, account_id)
  	g = Group.find group_id
  	a = Account.find account_id

  	result = RestClient.post a.ban_url, { :group_id => g.item_id, :group_name => g.name }
    raise "Notification Error" unless result.code == 200
  end
end