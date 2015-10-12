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
    expect(complaint.group.ban_until - Time.now > 2.days).to eq(true)
  end

  it "creates closed complaint" do
    account = FactoryGirl.create(:account)

    post :create, complaint: FactoryGirl.attributes_for(:closed_complaint).merge({account_id: account.id}), :format => :json

    expect(response.status).to be(201)
    parsed = JSON.parse(response.body)
    complaint = Complaint.last

    expect(parsed['id']).to eq(complaint.id)
    expect(parsed['account_id']).to eq(complaint.account_id)
    expect(parsed['url']).to eq(complaint.url)
    expect(parsed['group_id']).to eq(complaint.group_id)

    expect(complaint.group.banned).to eq(true)
    expect(complaint.group.ban_until).not_to be_nil
    expect(complaint.group.ban_until - Time.now > 25.days).to eq(true)
  end

  it "creates volk complaint" do
    account = FactoryGirl.create(:account)

    post :create, complaint: FactoryGirl.attributes_for(:volk_complaint).merge({account_id: account.id}), :format => :json

    expect(response.status).to be(201)
    parsed = JSON.parse(response.body)
    complaint = Complaint.last

    expect(parsed['id']).to eq(complaint.id)
    expect(parsed['account_id']).to eq(complaint.account_id)
    expect(parsed['url']).to eq(complaint.url)
    expect(parsed['group_id']).to eq(complaint.group_id)

    expect(complaint.group.banned).to eq(true)
    expect(complaint.group.ban_until).not_to be_nil
    expect(complaint.group.ban_until - Time.now > 2.days).to eq(true)
  end

  it "creates fucking bad complaint" do
    account = FactoryGirl.create(:account)

    post :create, complaint: FactoryGirl.attributes_for(:fucking_bad_complaint).merge({account_id: account.id}), :format => :json

    expect(response.status).to be(201)
    parsed = JSON.parse(response.body)
    complaint = Complaint.last

    expect(parsed['id']).to eq(complaint.id)
    expect(parsed['account_id']).to eq(complaint.account_id)
    expect(parsed['url']).to eq(complaint.url)
    expect(parsed['group_id']).to eq(complaint.group_id)

    expect(complaint.group.banned).to eq(true)
    expect(complaint.group.ban_until).not_to be_nil
    expect(complaint.group.ban_until - Time.now > 4.years).to eq(true)
  end

  it "creates bad complaint" do
    account = FactoryGirl.create(:account)

    post :create, complaint: FactoryGirl.attributes_for(:bad_complaint).merge({account_id: account.id}), :format => :json

    expect(response.status).to be(201)
    parsed = JSON.parse(response.body)
    complaint = Complaint.last

    expect(parsed['id']).to eq(complaint.id)
    expect(parsed['account_id']).to eq(complaint.account_id)
    expect(parsed['url']).to eq(complaint.url)
    expect(parsed['group_id']).to eq(complaint.group_id)

    expect(complaint.group.banned).to eq(true)
    expect(complaint.group.ban_until).not_to be_nil
    expect(complaint.group.ban_until - Time.now > 13.days).to eq(true)
    expect(complaint.group.ban_until - Time.now < 16.days).to eq(true)
  end

  it "creates closed complaint after usual complaint" do
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
    expect(complaint.group.ban_until - Time.now > 2.days).to eq(true)

    post :create, complaint: FactoryGirl.attributes_for(:closed_complaint).merge({account_id: account.id}), :format => :json

    expect(response.status).to be(201)
    parsed = JSON.parse(response.body)
    complaint = Complaint.last

    expect(parsed['id']).to eq(complaint.id)
    expect(parsed['account_id']).to eq(complaint.account_id)
    expect(parsed['url']).to eq(complaint.url)
    expect(parsed['group_id']).to eq(complaint.group_id)

    expect(complaint.group.banned).to eq(true)
    expect(complaint.group.ban_until).not_to be_nil
    expect(complaint.group.ban_until - Time.now > 25.days).to eq(true)
  end

  it "creates usual complaint after closed complaint" do
    account = FactoryGirl.create(:account)

    post :create, complaint: FactoryGirl.attributes_for(:closed_complaint).merge({account_id: account.id}), :format => :json

    expect(response.status).to be(201)
    parsed = JSON.parse(response.body)
    complaint = Complaint.last

    expect(parsed['id']).to eq(complaint.id)
    expect(parsed['account_id']).to eq(complaint.account_id)
    expect(parsed['url']).to eq(complaint.url)
    expect(parsed['group_id']).to eq(complaint.group_id)

    expect(complaint.group.banned).to eq(true)
    expect(complaint.group.ban_until).not_to be_nil
    expect(complaint.group.ban_until - Time.now > 25.days).to eq(true)

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
    expect(complaint.group.ban_until - Time.now > 25.days).to eq(true)
  end

end

