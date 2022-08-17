# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_account, only: %i[edit show update]
  after_action :verify_authorized, only: [:update]

  def index; end

  def show
    # @account = Account.find(params[:id])
    @posts = @account.posts.order(created_at: :desc)
  end

  def edit
    render 'accounts/Access_Denied' if @account != current_account
  end

  def update
    authorize @account
    # current_account.update(account_params)
    @account.update(account_params)
    redirect_to current_account
  end

  def search
    @account = Account.search_like_any([:full_name], params[:search])
    render template: 'accounts/search-results', locals: { account: @account } # remove render
  end

  private

  def find_account
    @account = Account.find_by id: params[:id]
    render 'accounts/Account_Not_Found' if @account.blank?
  end

  def account_params
    params.require(:account).permit(:username, :full_name, :website, :bio, :phone, :gender, :avatar, :private)
  end
end
