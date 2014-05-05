class SocialAccount < ActiveRecord::Base
  belongs_to :account

  LOCK_PERIOD = 1.day


  def lock_by!(a)
    if locked?
      raise LockAccountException.new if self.account != a
    else
      self.account = a
      self.locked_at = Time.now
      self.save!
    end
  end

  def locked?
    self.locked_at > LOCK_PERIOD.ago && !self.account.nil?
  end
  
end
