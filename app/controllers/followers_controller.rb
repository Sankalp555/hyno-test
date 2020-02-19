class FollowersController < ApplicationController
  before_action :authenticate_user!
  
  def follow
    if params[:following_id].blank?
      render json: {error: 'Please provide user whom to follow'}
      return
    end
    following_user = User.find_by_id(params[:following_id])
    if following_user.blank?
      render json: {error: 'Please proivde valid user to follow'}
      return
    end
    follow = Follow.where(user_id: current_user.id, following_id: params[:following_id])
    if follow.blank?
      Follow.create(user_id: current_user.id, following_id: params[:following_id])
      render json: {message: "Now you are following this user"}
    else
      render json: {error: 'Already following.'}
      return
    end
  end

  def unfollow
    if params[:unfollow_id].blank?
      render json: {error: 'Please provide user to Unfollow'}
      return
    end
    user = User.find_by_id(params[:unfollow_id])
    if user.blank?
      render json: {error: 'Please proivde valid user to Unfollow'}
      return
    end
    follow = Follow.where(user_id: current_user.id, following_id: params[:unfollow_id])
    if follow.blank?
      render json: {message: "You do not follow this user"}
    else
      follow.destroy_all
      render json: {error: 'Sucessfully Unfollowed.'}
      return
    end
  end
end