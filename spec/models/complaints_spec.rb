require 'rails_helper'

RSpec.describe Complaint, :type => :model do

  it 'complaint creation banes group' do
    complaint = FactoryGirl.create(:complaint)
    expect(complaint.group.banned).to eq(true)
  end

  it 'closed complaint creation banes group for long' do
    complaint = FactoryGirl.create(:closed_complaint)
    Banner.new(complaint.group).ban!(Group::BAN_REASON::CLOSED)

    expect(complaint.group.banned).to eq(true)
    expect(Time.now + 1.month - complaint.group.ban_until < 1.day).to eq(true)
  end

  it 'complaint creation banes group for 3 days' do
    complaint = FactoryGirl.create(:closed_complaint)
    Banner.new(complaint.group).ban!
    
    expect(complaint.group.banned).to eq(true)
    expect(Time.now + 3.days - complaint.group.ban_until < 1.day).to eq(true)
  end

  it 'volk complaint creation banes group for 3 days' do
    complaint = FactoryGirl.create(:volk_complaint)
    Banner.new(complaint.group).ban!
    
    expect(complaint.group.banned).to eq(true)
    expect(Time.now + 3.days - complaint.group.ban_until < 1.day).to eq(true)
  end

  it 'fucking bad complaint creation banes group for long' do
    complaint = FactoryGirl.create(:fucking_bad_complaint)
    Banner.new(complaint.group).ban!(Group::BAN_REASON::FUCKING_BAD)

    expect(complaint.group.banned).to eq(true)
    expect(Time.now + 5.years - complaint.group.ban_until < 1.day).to eq(true)
  end

  it 'bad complaint creation banes group for long' do
    complaint = FactoryGirl.create(:bad_complaint)
    Banner.new(complaint.group).ban!(Group::BAN_REASON::BAD)

    expect(complaint.group.banned).to eq(true)
    expect(Time.now + 15.days - complaint.group.ban_until < 1.day).to eq(true)
  end

end