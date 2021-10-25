class Admin::RelationshipsController < ApplicationController
  # フォロー・フォロワー一覧表示
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end