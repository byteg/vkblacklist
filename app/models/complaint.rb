class Complaint < ActiveRecord::Base
#  attr_accessible :url, :account_id, :comment

  belongs_to :group, :counter_cache => true
  belongs_to :account

  before_validation :bind_to_group
  before_validation :bind_to_account

  after_create :ban_much_complained

  validates_presence_of :group
  validates_presence_of :account

  validates_presence_of :group_id
  validates_presence_of :account_id

  def bind_to_group
  	self.group = Group.find_by_url(self.url) || Group.create(:url => self.url)
  end

  def bind_to_account
  	self.account = Account.find self.account_id
  end

  def ban_much_complained
    if self.group.complaints_count >= Group::CRITICAL_COMPLAINTS_COUNT
      self.group.ban!
    end
  end



end
