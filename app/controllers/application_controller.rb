# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_account!

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:full_name, :email, :password, :username) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :username, :private)
    end
  end

  # def after_sign_in_path_for(resource)
  #   stored_location_for(resource) || dashboard_path
  # end
  def find_account
    @account = Account.find_by id: params[:id]
    render 'accounts/Account_Not_Found' if @account.blank?
  end

  def pundit_user
    Account.find(current_account.id)
  end
end
