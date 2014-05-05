class Api::AccountsController < ApplicationController
  before_action :find_account

  def lock
    account = SocialAccount.find_or_create_by(:name => params[:name], :uid => params[:uid])
    account.lock!(@service)
  end

  protected

  def find_account
    @account = Account.where(:token => params[:token]).first
    if account.blank?
      
    end

  end

end