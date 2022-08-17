# frozen_string_literal: true

class FollowsController < ApplicationController
  def follow_user
    user_id = params[:format]
    @follow = current_account.follows.create(following_id: user_id)
    if @follow.save
      redirect_to account_path(user_id)
      flash[:notice] = 'User Followed!'

    else
      flash[:alert] = 'Unable to Follow'
      redirect_to account_path(user_id)
    end
  end

  def unfollow_user
    user_id = params[:format]
    follow_id = Follow.find_by(account_id: current_account.id, following_id: user_id)
    if current_account.follows.delete(follow_id)
      redirect_to account_path(user_id)
      flash[:notice] = 'User Unfollowed '
    else
      flash[:alert] = 'Unable to Unfollow'
      redirect_to account_path
    end
  end
end
