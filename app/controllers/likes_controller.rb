# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_likes, only: [:destroy]

  def create
    @like = current_account.likes.build(likes_params)
    @post = @like.post
    @like.save
    # if @like.save
    #   respond_to :js
    # else
    #   flash[:alert] = 'Something went wrong'
    # end
  end

  def destroy
    # @like = Like.find(params[:id])
    @post = @like.post
    @like.destroy
    # if @like.destroy
    #   respond_to :js
    # else
    #   flash[:alert] = 'Something Went Wrong'
    # end
  end

  private

  def find_likes
    @like = Like.find(params[:id])
  end

  def likes_params
    params.permit(:post_id)
  end
end
