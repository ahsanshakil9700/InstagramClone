class AccountsController < ApplicationController

  before_action :authenticate_account!
  def index

  end

  def show
    @account = Account.find(params[:id])
  end
end
