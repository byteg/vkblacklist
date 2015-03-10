require 'rails_helper'

RSpec.describe ComplaintsController, :type => :controller do

  it "creates complaint" do
    account = FactoryGirl.create(:account)

    post :create, complaint: FactoryGirl.attributes_for(:complaint).merge({account_id: account.id}), :format => :json

    expect(response.status).to be(201)
    parsed = JSON.parse(response.body)
    complaint = Complaint.last

    expect(parsed['id']).to eq(complaint.id)
    expect(parsed['account_id']).to eq(complaint.account_id)
    expect(parsed['url']).to eq(complaint.url)
    expect(parsed['group_id']).to eq(complaint.group_id)

    expect(complaint.group.banned).to eq(true)
    expect(complaint.group.ban_until).not_to be_nil
  end



end

