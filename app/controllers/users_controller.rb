class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def profile
    following_ids = Follow.where(user_id: current_user.id).pluck(:following_id)
    @following = User.where(id: following_ids)
    follower_ids = Follow.where(following_id: current_user.id).pluck(:user_id)
    @followers = User.where(id: follower_ids)
  end
end