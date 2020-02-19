class TweetsController < ApplicationController
  before_action :authenticate_user!
  

  def index
    followers_ids = Follow.where(user_id: current_user.id).pluck(:following_id)
    if params[:tweet][:order] == 'desc'
      @tweets = Tweet.where(user_id: followers_ids).order("created_at DESC")
    else
      @tweets = Tweet.where(user_id: followers_ids).order("created_at ASC")
    end
  end

  def create
    if params[:tweet][:message].blank?
      render json: {error: 'Please proivde valid parameters'}
      return
    end
    tweet = current_user.tweets.create(message: params[:tweet][:message])
    render json: {id: tweet.id, message: tweet.message}
  end
end