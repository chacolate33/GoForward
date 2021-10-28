class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(created_at: "DESC").page(params[:page]).per(20)
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
    @groups = Kaminari.paginate_array(@groups).page(params[:page]).per(20)
  end

  def update
    # 退会ステータスの変更
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "You have updated the status successfully."
    redirect_to request.referer
  end

  private

  def user_params
    params.permit(:is_deleted)
  end
end
