require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do

  it "group is in blacklist after closed complaint creation" do
    complaint = FactoryGirl.create(:closed_complaint)
    group = complaint.group

    get :by_group_id, group_id: group.item_id, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['id']).to eq(group.id)
    expect(parsed['url']).to eq(group.url)
    expect(parsed['banned']).to eq(true)
  end

  it "group is in blacklist after fucking bad complaint creation" do
    complaint = FactoryGirl.create(:fucking_bad_complaint)
    group = complaint.group

    get :by_group_id, group_id: group.item_id, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['id']).to eq(group.id)
    expect(parsed['url']).to eq(group.url)
    expect(parsed['banned']).to eq(true)
  end

  it "group is in blacklist after volk complaint creation" do
    complaint = FactoryGirl.create(:volk_complaint)
    group = complaint.group

    get :by_group_id, group_id: group.item_id, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['id']).to eq(group.id)
    expect(parsed['url']).to eq(group.url)
    expect(parsed['banned']).to eq(true)
  end

  it "group is in blacklist after bad complaint creation" do
    complaint = FactoryGirl.create(:bad_complaint)
    group = complaint.group

    get :by_group_id, group_id: group.item_id, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['id']).to eq(group.id)
    expect(parsed['url']).to eq(group.url)
    expect(parsed['banned']).to eq(true)
  end

  it "group is in blacklist after usual complaint creation" do
    complaint = FactoryGirl.create(:complaint)
    group = complaint.group

    get :by_group_id, group_id: group.item_id, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['id']).to eq(group.id)
    expect(parsed['url']).to eq(group.url)
    expect(parsed['banned']).to eq(true)
  end

  it "group is in blacklist after closed complaint creation" do
    complaint = FactoryGirl.create(:closed_complaint)
    group = complaint.group

    get :exists, url: group.url, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['result']).to eq(1)
  end

  it "group is in blacklist after fucking bad complaint creation" do
    complaint = FactoryGirl.create(:fucking_bad_complaint)
    group = complaint.group

    get :exists, url: group.url, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['result']).to eq(1)
  end

  it "group is in blacklist after closed complaint creation" do
    complaint = FactoryGirl.create(:volk_complaint)
    group = complaint.group

    get :exists, url: group.url, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['result']).to eq(1)
  end

  it "group is in blacklist after bad complaint creation" do
    complaint = FactoryGirl.create(:bad_complaint)
    group = complaint.group

    get :exists, url: group.url, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['result']).to eq(1)
  end

  it "group is in blacklist after complaint creation" do
    complaint = FactoryGirl.create(:complaint)
    group = complaint.group

    get :exists, url: group.url, :format => :json

    expect(response.status).to be(200)
    parsed = JSON.parse(response.body)

    expect(parsed['result']).to eq(1)
  end

end