class GroupUsersController < ApplicationController
  def create
    # 引数を取る
    @params = params[:group_id]
    @group_user = GroupUser.new
    @group_user.user_id = current_user.id
    @group_user.group_id = @params
    @group_user.save
    redirect_to request.referer
  end

  def destroy
    # 引数を取る
    @params = params[:group_id]
    @group_user = GroupUser.find_by(group_id: @params, user_id: current_user.id)
    @group_user.destroy
    redirect_to request.referer
  end
end
