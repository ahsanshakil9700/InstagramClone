# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_comments, only: [:destroy]

  def index
    @comments = @post.comments.includes(:account)
  end

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post if @comment.save
    # if @comment.save
    #   @post = @comment.post
    #   # respond_to :js
    # else
    #   flash[:alert] = 'Something Went Wrong'
    # end
  end

  def destroy
    # @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    # if @comment.destroy
    #   respond_to :js
    # else
    #   flash[:alert] = 'Something Went Wrong'
    # end
  end

  private

  def find_comments
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.required(:comment).permit(:account_id, :post_id, :content)
  end
end
