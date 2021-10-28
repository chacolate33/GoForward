class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  
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
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(20)
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_root_path
  end 

end
