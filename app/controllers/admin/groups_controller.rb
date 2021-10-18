class Admin::GroupsController < ApplicationController
  def show
    @group = Group.find(params[:id])
    @leader = User.find_by(id: @group.leader_id)
    
    # 所属ユーザー一覧表示
    @group_users = GroupUser.where(group_id: @group.id)
    @users = []
    @group_users.each do |group_user|
      user = User.find_by(id: group_user.user_id)
      @users.push(user)
    end
      
  end

  def destroy
  end
end
