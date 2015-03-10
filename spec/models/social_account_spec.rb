require 'rails_helper'

RSpec.describe SocialAccount, :type => :model do
  it 'check social account cannot be locked by different accounts' do
    first_account = FactoryGirl.create(:account)
    second_account = FactoryGirl.create(:account)

    social_account = SocialAccount.create(:name => :vkontakte, :uid => 1)

    social_account.lock_by!(first_account)
    expect{social_account.lock_by!(second_account)}.to raise_error(LockAccountException)
  end
end