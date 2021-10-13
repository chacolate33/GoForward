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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated your infomation successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
      
  end
  
  private
  
  def user_params 
    params.require(:user).permit(:name, :introduction, :image)
  end
end
