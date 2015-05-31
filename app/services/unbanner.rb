class Unbanner < GroupPerformer

  def unban!
    group.complaints.destroy_all
    group.banned = false
    group.save!

    send_unban_notifications
  end

  def send_unban_notifications
    if !Rails.env.test?
      Account.unban_subscribed.pluck(:id).each { |aid|
        UnbanNotifier.perform_async(group.id, aid)
      }
    end
  end

end