class StoriesController < ApplicationController

  before_action :authenticate_account!

  def create
    @story = current_account.stories.build
    if params[:image]
      save_story

    else
      flash[:alert] = "Unable to create story"
      redirect_to root_path
    end
  end

  def show
    @user = Account.find(params[:id])
    # redirect_to root_path unless @user == current_account
    @stories = @user.stories
    @oldest_story = @stories.order('created_at asc').first

  end

  def destroy
    @story = Story.find_by id: params[:id]
    if @story.account == current_account # check to make sure current user only deletes his story, later in views I will make sure there is no visible button to delete someone else's story
      if @story.destroy
        flash[:alert] = "Story Deleted"
      else
        flash[:alert] = "Something Went Wrong"
      end
    end
    redirect_to root_path
  end

  private
  def save_story
    if @story.save
      @story.photos.create(image: params[:image])
      flash[:notice] = "Story Saved"
    else
      flash[:alert] = "Unable to save story"
    end
    redirect_to root_path
  end
end
