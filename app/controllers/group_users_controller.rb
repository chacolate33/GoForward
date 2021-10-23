class GroupUsersController < ApplicationController
  def create
    # 引数を取る
    @params = params[:group_id]
    @group_user = GroupUser.new
    @group_user.user_id = group_user_params[:user_id]
    @group_user.group_id = @params
    @group_user.save
    apply = Apply.find(group_user_params[:apply_id])
    apply.destroy
    flash[:notice] = "ユーザーがグループに加入しました。"
    redirect_to request.referer
  end

  def destroy
    # 引数を取る
    @params = params[:group_id]
    @group_user = GroupUser.find_by(group_id: @params, user_id: current_user.id)
    @group_user.destroy
    redirect_to request.referer
  end

  private
  def group_user_params
    params.permit(:group_id, :user_id, :apply_id)
  end

end
