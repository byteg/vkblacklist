class SocialAccount < ActiveRecord::Base
  attr_accessible :account_id, :locked_at, :name, :uid

  belongs_to :account

  before_validation :set_locked_at, :on => :create


  def set_locked_at
    self.locked_at = Time.now
  end
  
end
