require 'rails_helper'

RSpec.describe Complaint, :type => :model do

  it 'complaint creation banes group' do
    complaint = FactoryGirl.create(:complaint)
    expect(complaint.group.banned).to eq(true)
  end

  it 'complaint creation banes unbanned group' do
    complaint = FactoryGirl.create(:complaint)
    complaint.group.unban!

    complaint2 = FactoryGirl.create(:complaint)

    expect(complaint2.group.banned).to eq(true)
  end

end