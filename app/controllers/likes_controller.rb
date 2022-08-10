class LikesController < ApplicationController
  before_action :authenticate_account!


  def create
    @like = current_account.likes.build(likes_params)
    @post = @like.post
    if @like.save
      respond_to :js

    else
      flash[:alert] = "Something went wrong"
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    else
      flash[:alert] = "Something Went Wrong"
    end
  end

  private
  def likes_params
    params.permit(:post_id)
  end
end

