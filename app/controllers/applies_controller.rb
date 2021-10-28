class AppliesController < ApplicationController
  before_action :authenticate_user!
  # グループ加入申請を作る
  def create
    current_user.applies.create(group_id: apply_params[:group_id])
    flash[:notice] = "You applied to join the group."
    redirect_to request.referer
  end
  　 # グループ加入申請の拒否と取り消し
  def destroy
    @apply = Apply.find(params[:id])
    @apply.destroy
    flash[:notice] = "You canceled the application."
    redirect_to request.referer
  end

  # 申請をしてグループリーダーの承認を待っているユーザーの一覧
  def index
    @applies = Apply.where(group_id: params[:group_id])
  end

  private

  def apply_params
    params.permit(:group_id)
  end
end
