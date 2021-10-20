class AppliesController < ApplicationController
  def create
    current_user.applies.create(group_id: apply_params[:group_id])
    flash[:notice] = "加入申請しました。"
    redirect_to request.referer
  end

  def destroy
  end
  
  def index
    @applies = Apply.where(group_id: params[:group_id])
  end
  
  private
  def apply_params
    params.permit(:group_id)
  end
end
