require 'spec_helper'

describe "check social accounts lock" do
  it 'check social account cannot be locked by different accounts' do
    first_account = create(:account)
    second_account = create(:account)
    social_account = SocialAccount.create(:name => :vkontakte, :uid => 1)

    social_account.lock_by!(first_account)
    expect{social_account.lock_by!(second_account)}.to raise_error(LockAccountException)
  end
end