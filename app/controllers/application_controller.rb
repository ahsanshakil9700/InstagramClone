# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_account!

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  protected

  def handle_record_not_found
    flash[:notice] = "Record not found!"
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:full_name, :email, :password, :username) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :username, :private)
    end
  end

  def find_account
    @account = Account.find_by id: params[:id]
    return if @account

    raise ActiveRecord::RecordNotFound
  end

  def pundit_user
    Account.find(current_account.id)
  end

  def user_not_authorized
    flash[:alert] = 'Not authorized to perform this action! Induced by Pundit Authorization'
    redirect_to root_path
  end
end
