# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_likes, only: [:destroy]
  after_action :verify_authorized, only: %i[destroy create]

  def create
    @like = current_account.likes.build(likes_params)
    @post = @like.post
    authorize @like
    @like.save
  end

  def destroy
    authorize @like
    @post = @like.post
    @like.destroy
  end

  private

  def find_likes
    @like = Like.find(params[:id])
  end

  def likes_params
    params.permit(:post_id)
  end
end
