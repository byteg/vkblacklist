class BanTimeCounter

  VOLK_DEFAULT_VALUE = 3.hours
  def initialize(group)
    @group = group
  end

  def time_for_volk
    last_day_complaints_count = @group.complaints.for_volk.where('created_at > ?', 1.day.ago).count
    if @group.banned?
      return 150.hours if last_day_complaints_count > 1000
      return 100.hours if last_day_complaints_count > 500
      return 72.hours if last_day_complaints_count > 300
      return 50.hours if last_day_complaints_count > 100
      return 30.hours if last_day_complaints_count > 30
      return 24.hours if last_day_complaints_count > 15
      return 12.hours if last_day_complaints_count > 5
      return 6.hours if last_day_complaints_count > 3
      return 3.hours if last_day_complaints_count > 1
      return VOLK_DEFAULT_VALUE
    else
      return last_day_complaints_count > 0 ? 24.hours : VOLK_DEFAULT_VALUE
    end
    # VOLK_DEFAULT_VALUE
  end
  
end
