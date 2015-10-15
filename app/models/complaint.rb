class Complaint < ActiveRecord::Base
  belongs_to :group, counter_cache: true
  belongs_to :account

  before_validation :bind_to_group
  before_validation :bind_to_account

  validates_presence_of :group
  validates_presence_of :account

  validates_presence_of :group_id
  validates_presence_of :account_id

  scope :for_volk, -> { where(comment: :volk) }

  def bind_to_group
    self.group = Group.find_by_url(url) || Group.create(url: url)
  end

  def bind_to_account
    self.account = Account.find account_id
  end

  def reason
    return Group::BAN_REASON::CLOSED if "closed" == comment
    return Group::BAN_REASON::FUCKING_BAD if "fucking_bad" == comment
    return Group::BAN_REASON::BAD if "bad" == comment
    return Group::BAN_REASON::VOLK if "volk" == comment
    nil
  end
end
