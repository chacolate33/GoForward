class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @group_users = GroupUser.where(user_id: current_user.id)
    @groups = []
    @group_users.each do |group_user|
      group = Group.find_by(id: group_user.group_id)
      @groups.push(group)
    end
  end

  def confirm
  end

  def leave
  end

  def edit
  end

  def update
  end
end
