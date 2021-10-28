class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
  # フォロー・フォロワー一覧表示
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(20)
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(20)
  end
end
