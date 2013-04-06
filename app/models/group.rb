class Group < ActiveRecord::Base
  attr_accessible :name

  attr_accessor :url

  before_validation :set_item_id
  before_validation :set_ban_until

  after_save :send_unban_notifications
  after_save :send_ban_notifications

  scope :banned, where(:banned => true)
  scope :checked, where(:checked => true)

  def unban!
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

  def self.check_exists?(url)
    name = name_by_url(url)
    return false if name.nil?

    Group.where(:item_id => item_id_by_name(name)).exists?
  end

  def self.name_by_url(url)
    return url =~ /https?:\/\/vk.com\/([\w.]+)/ ? $1 : nil
  end

  def self.item_id_by_name(name)
    app = VK::Application
    result = app.groups.getById :gid => name
    result.blank ? nil : result.first[:gid]
  end

  protected

  def set_item_id
  	self.item_id = item_id_by_name(self.name)
  end

  def set_ban_until
    self.ban_until = Time.now + 3.days
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
