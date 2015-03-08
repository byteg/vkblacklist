class Account < ActiveRecord::Base
  scope :ban_subscribed, -> { where('ban_url IS NOT NULL') }
  scope :unban_subscribed, -> { where('unban_url IS NOT NULL') }

  before_validation :set_token, :on => :create

  def set_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Account.exists?(token: random_token)
    end
  end

  def generate_token!
    set_token
    self.save!
  end
end
