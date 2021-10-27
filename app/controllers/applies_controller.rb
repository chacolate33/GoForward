class AppliesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    current_user.applies.create(group_id: apply_params[:group_id])
    flash[:notice] = "You applied to join the group."
    redirect_to request.referer
  end

  def destroy
    @apply = Apply.find(params[:id])
    @apply.destroy
    flash[:notice] = "You canceled you application."
    redirect_to request.referer

  end

  def index
    @applies = Apply.where(group_id: params[:group_id])
  end

  private
  def apply_params
    params.permit(:group_id)
  end
end
