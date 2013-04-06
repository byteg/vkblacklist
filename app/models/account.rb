class Account < ActiveRecord::Base
  attr_accessible :ban_url, :unban_url

  scope :ban_subscribed, where('ban_url IS NOT NULL')
  scope :unban_subscribed, where('ban_url IS NOT NULL')
end
