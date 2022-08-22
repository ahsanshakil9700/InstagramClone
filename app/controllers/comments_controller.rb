# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_comments, only: [:destroy]
  after_action :verify_authorized, only: %i[destroy create]

  def index
    @comments = @post.comments.includes(:account)
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    @post = @comment.post if @comment.save
  end

  def destroy
    authorize @comment
    @post = @comment.post
    @comment.destroy
  end

  private

  def find_comments
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.required(:comment).permit(:account_id, :post_id, :content)
  end
end
