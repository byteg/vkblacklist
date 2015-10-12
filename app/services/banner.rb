class Banner < GroupPerformer

  def ban!(reason = nil)
    group.ban_until = [get_ban_until_by_reason(reason), group.ban_until || Time.now].max

    group.banned = true
    group.save!

    send_ban_notifications
  end

  def send_ban_notifications
    if !Rails.env.test?
      Account.ban_subscribed.pluck(:id).each { |aid|
        BanNotifier.perform_async(group.id, aid)
      }
    end
  end

  def get_ban_until_by_reason(reason)
    return Time.now + 3.days if reason.nil?
    return Time.now + 3.days if Group::BAN_REASON::VOLK == reason
    return Time.now + 15.days if Group::BAN_REASON::BAD == reason
    return Time.now + 1.month if Group::BAN_REASON::CLOSED == reason
    return Time.now + 5.years if Group::BAN_REASON::FUCKING_BAD == reason
  end
end