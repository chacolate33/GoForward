class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # 以下所属グループ一覧表示の記述
    @group_users = GroupUser.where(user_id: @user.id)
    @groups = []
    @group_users.each do |group_user|
      group = Group.find_by(id: group_user.group_id)
      @groups.push(group)
    end
  end

  def update
  end
end
