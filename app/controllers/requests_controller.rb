# frozen_string_literal: true

# to handle requests
class RequestsController < ApplicationController
  before_action :find_request, only: [:update]

  def create
    @request = current_account.requests.create(following_id: params[:following_id])
    if @request.save
      flash[:notice] = 'Follow request sent!'
    else
      flash[:alert] = "Errors. Couldn't send follow request"
    end
    redirect_to account_path(params[:following_id])
  end

  def index
    @requests = Request.pending_requests(current_account)
  end

  def update
    @request.update(is_accepted: params[:is_accepted])
    if @request.is_accepted
      create_follow(@request.sender, @request.following_id)
      (flash[:notice] = 'Request accepted!')
    else
      (flash[:notice] = 'Request declined!')
    end
    remove_request(@request.id)
    redirect_to root_path
  end

  def remove_request(request_id)
    (flash[:alert] = 'An unexpected error occurred!') unless Request.delete(request_id)
  end

  def remove_follow_request
    user_id = params[:format]
    request_id = Request.find_by(account_id: current_account.id, following_id: user_id)
    if current_account.requests.delete(request_id)
      (flash[:notice] = 'Request removed!')
    else
      (flash[:alert] = 'An unexpected error occurred!')
    end
    redirect_to account_path(user_id)
  end

  private

  def create_follow(user, user_id)
    @follow = user.follows.create(following_id: user_id)
    if @follow.save
      (flash[:notice] = 'Accepted follow request!')
    else
      (flash[:alert] = 'An unexpected error occurred!')
    end
  end

  def find_request
    @request = Request.find(params[:id])
  end
end