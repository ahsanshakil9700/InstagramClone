# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_account!

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:full_name, :email, :password, :username) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :username, :private)
    end
  end

  def find_account
    @account = Account.find_by id: params[:id]
    render 'accounts/Account_Not_Found' if @account.blank?
  end

  def pundit_user
    Account.find(current_account.id)
  end

  def user_not_authorized
    flash[:alert] = 'Not authorized to perform this action! Induced by Pundit Authorization'
    redirect_to edit_account_path(current_account)
  end
end
