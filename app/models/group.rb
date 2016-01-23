class Group < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  CRITICAL_COMPLAINTS_COUNT = 1

  validates_format_of :url, with: /https?:\/\/(m\.)?vk.com\/([\w.]+)/

  before_validation :set_item_id, on: :create
  before_validation :set_ban_until, on: :create


  has_many :complaints, dependent: :destroy

  module BAN_REASON
    CLOSED = 1
    FUCKING_BAD = 2
    BAD = 3
    VOLK = 4
  end

  scope :banned, -> { where(banned: true) }
  scope :checked, -> { where(checked: true) }

  def self.check_unbanned
    Group.banned.where('ban_until < ?', Time.now).all.each { |g|
      Unbanner.new(g).unban!
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
    return $3 if url =~ /https?:\/\/(m\.)?vk.com\/(club|public)(\d+)/
    return $2 if url =~ /https?:\/\/(m\.)?vk.com\/([\w.]+)/
    nil
  end

  def set_ban_until
    self.ban_until = Time.now + 3.hours
    self.banned = true
  end

  def self.item_id_by_name(name)
    return [name, "Test group"] if Rails.env.test?
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
    self.title = truncate(title, :length => 95).strip.codepoints.select {|c| c < 50000}.pack("U*")
  end


end
