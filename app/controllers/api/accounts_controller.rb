class Api::AccountsController < ApplicationController
  before_filter :find_account

  def lock
    begin
      account = SocialAccount.find_or_create_by(:name => params[:name], :uid => params[:uid])
      account.lock_by!(@account)

      @result = { error_code: 0, error_message: "OK"}
    rescue LockAccountException => ex
      @result = { error_code: 2, error_message: "Account already locked" }
    end

    respond_to do |format|
      format.xml { render xml: @result }
      format.json { render json: @result }
    end

  end

  protected

  def find_account
    @account = Account.where(:token => params[:token]).first
    if @account.blank?
      result = { error_code: 1, error_message: "Account not found, pass correct token please"}
      respond_to do |format|
        format.xml { render xml: result }
        format.json { render json: result }
      end
    end
  end

  #def account_params
  #  params.permit(:name, :ui)
  #end

end