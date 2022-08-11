class PostsController < ApplicationController
    before_action :authenticate_account!
    before_action :find_post, only: [:destroy, :edit, :update, :show]
    def index
      @posts = Post.all.limit(100).includes(:photos, :account, :likes).order('created_at desc')
      @post = Post.new
      @stories_attached_user = Account.has_stories
      @story = Story.new
    end


    def create
      @post = current_account.posts.build(post_params)
      if @post.save
        if params[:images]
          params[:images]&.each do |img|
            @post.photos.create(image: img)
          end
        end

        redirect_to posts_path
        flash[:notice] = "Saved ..."
      else
        flash[:alert] = "Something went wrong ..."
        redirect_to posts_path
      end
    end



    def destroy

      if @post.account == current_account
        if @post.destroy
          flash[:notice] = "Post Deletes successfully"
        else
          flash[:alert] = "Something went wrong"
        end

      else
        flash[:alert] = "You need to sign in as the user of the post"
      end

      redirect_to root_path

    end

    def edit
      if @post.account == current_account
        @post = Post.find(params[:id])
      end
    end

    def update
      @post = Post.find(params[:id])
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
      flash[:danger] = "Post Not Found"
      redirect_to root_path
    end

    def post_params
      params.require(:post).permit(:description)
    end
end
