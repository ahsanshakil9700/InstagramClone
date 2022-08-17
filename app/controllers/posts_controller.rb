# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_post, only: %i[destroy edit update show]
  after_action :verify_authorized, only: %i[edit destroy]

  def index
    @posts = Post.all.limit(100).includes(:photos, :account, :likes).order('created_at desc')
    @post = Post.new
    @stories_attached_user = Account.where('EXISTS(SELECT * FROM stories WHERE account_id = accounts.id)')
    @story = Story.new
  end

  def create
    @post = current_account.posts.build(post_params)
    if params[:images] && params[:images].count < 11
      save_photos
    else
      redirect_to posts_path
      flash[:alert] = 'Please add images (at max 10)!'
    end
  end

  def destroy
    authorize @post.account
    if @post.destroy
      flash[:notice] = 'Post Deletes successfully'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to root_path
  end

  def edit
    authorize @post.account
  end

  def update
    @post.update(description: params[:post][:description])
    redirect_to root_path
  end

  def show
    @photos = @post.photos
    @likes = @post.likes.includes(:account)
    @comment = Comment.new
    @is_liked = @post.is_liked(current_account)
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:danger] = 'Post Not Found'
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:description)
  end

  def save_photos
    if @post.save
      save_photos_safely
    else
      (flash[:alert] = 'An unexpected error occurred!')
    end
    redirect_to root_path
  end

  def save_photos_safely
    params[:images]&.each do |img|
      @post.photos.create(image: img)
    end
    (flash[:notice] = 'Saved!')
  rescue StandardError
    redirect_to root_path
    (flash[:alert] = 'Please add an image')
  end
end
