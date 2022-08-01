class AccountsController < ApplicationController

  before_action :authenticate_account!
  def index

  end

  def show
    @account = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    current_account.update(account_params)
    redirect_to current_account
  end

  private
  def account_params
    params.require(:account).permit(:username, :full_name, :website, :bio, :phone, :gender)
  end
end