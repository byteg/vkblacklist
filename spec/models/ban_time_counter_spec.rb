require 'rails_helper'

RSpec.describe BanTimeCounter, :type => :model do

  it 'bans for 3 hours with 1 complaint' do
    complaint = FactoryGirl.create(:volk_complaint)
    expect(BanTimeCounter.new(complaint.group).time_for_volk).to eq(3.hours)
  end

  it 'bans for 6 hours with 2 complaints' do
    group = nil
    2.times {
      complaint = FactoryGirl.create(:volk_complaint)
      group = complaint.group
    }
    expect(BanTimeCounter.new(group).time_for_volk).to eq(6.hours)
  end

  it 'bans for 12 hours with 4 complaints' do
    group = nil
    4.times {
      complaint = FactoryGirl.create(:volk_complaint)
      group = complaint.group
    }
    expect(BanTimeCounter.new(group).time_for_volk).to eq(12.hours)
  end

  it 'bans for 24 hours with 6 complaints' do
    group = nil
    6.times {
      complaint = FactoryGirl.create(:volk_complaint)
      group = complaint.group
    }
    expect(BanTimeCounter.new(group).time_for_volk).to eq(24.hours)
  end

  it 'bans for 48 hours with 16 complaints' do
    group = nil
    16.times {
      complaint = FactoryGirl.create(:volk_complaint)
      group = complaint.group
    }
    expect(BanTimeCounter.new(group).time_for_volk).to eq(48.hours)
  end

  it 'bans for 72 hours with 31 complaints' do
    group = nil
    31.times {
      complaint = FactoryGirl.create(:volk_complaint)
      group = complaint.group
    }
    expect(BanTimeCounter.new(group).time_for_volk).to eq(72.hours)
  end

  

end