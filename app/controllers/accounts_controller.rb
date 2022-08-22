# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_account, only: %i[edit show update]
  after_action :verify_authorized, only: [:update]

  def show
    @posts = @account.posts.order(created_at: :desc)
  end

  def edit
    authorize @account
  end

  def update
    authorize @account
    @account.update(account_params)
    redirect_to current_account
  end

  def search
    @account = Account.search_like_any([:full_name], params[:search])
  end

  private

  def find_account
    @account = Account.find params[:id]
  end

  def account_params
    params.require(:account).permit(:username, :full_name, :website, :bio, :phone, :gender, :avatar, :private)
  end
end
