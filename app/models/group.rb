class Group < ActiveRecord::Base
  attr_accessible :url

  CRITICAL_COMPLAINTS_COUNT = 3

  validates_format_of :url, :with => /https?:\/\/vk.com\/([\w.]+)/

  before_validation :set_item_id, :on => :create
  before_validation :set_ban_until

  has_many :complaints, :dependent => :destroy

  after_save :send_unban_notifications
  after_save :send_ban_notifications

  scope :banned, where(:banned => true)
  scope :checked, where(:checked => true)

  def unban!
    self.complaints.destroy_all
    self.banned = false
    self.save!
  end

  def ban!
    self.banned = true
    self.save!
  end

  def self.check_unbanned
    Group.banned.where('ban_until < ?', Time.now).all.each { |g|
      g.unban!
    }
  end

  def self.find_by_url(url)
    return nil if url.blank?

    name = name_by_url(url)
    return nil if name.nil?

    item_id = item_id_by_name(name)

    item_id.nil? ? nil : Group.where(:item_id => item_id.first).first
  end

  def self.name_by_url(url)
    return $2 if url =~ /https?:\/\/vk.com\/(club|public)(\d+)/
    return $1 if url =~ /https?:\/\/vk.com\/([\w.]+)/
    nil
  end

  def self.item_id_by_name(name)
    #return name if name.nil? || name.number?

    begin
      app = VK::Application.new
      result = app.groups.getById(:gid => name)
      result = result.blank? ? nil : [result.first['gid'], result.first['name']]
    rescue VK::ApiException
      result = nil
    end
    result
  end

  protected

  def set_item_id
    self.name = Group.name_by_url(self.url)
  	self.item_id, self.title = Group.item_id_by_name(self.name)
  end

  def set_ban_until
    if !self.ban_until || (self.banned_changed? && self.banned)
      self.ban_until = Time.now + 3.minutes
    end
  end

  def send_ban_notifications
  	if self.banned_changed? && self.banned
  	  Account.ban_subscribed.pluck(:id).each { |aid|
  	    BanNotifier.perform_async(self.id, aid)
  	  }
    end
  end

  def send_unban_notifications
    if self.banned_changed? && !self.banned
  	  Account.unban_subscribed.pluck(:id).each { |aid|
  	    UnbanNotifier.perform_async(self.id, aid)
  	  }
    end
  end

end
