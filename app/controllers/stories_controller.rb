# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_account, only: [:show]
  before_action :find_story, only: [:destroy]
  after_action :verify_authorized, only: [:destroy]

  def create
    @story = current_account.stories.build
    if params[:image]
      save_story

    else
      flash[:alert] = 'Unable to create story'
      redirect_to root_path
    end
  end

  def show
    # @user = Account.find(params[:id])
    # redirect_to root_path unless @user == current_account
    @stories = @account.stories
    @oldest_story = @stories.order('created_at asc').first
  end

  def destroy
    authorize @story.account
    flash[:alert] = if @story.destroy
                      'Story Deleted'
                    else
                      'Something Went Wrong'
                    end
    redirect_to root_path
  end

  private

  def save_story
    if @story.save
      @story.photos.create(image: params[:image])
      flash[:notice] = 'Story Saved'
    else
      flash[:alert] = 'Unable to save story'
    end
    redirect_to root_path
  end

  def find_story
    @story = Story.find_by id: params[:id]
  end
end
