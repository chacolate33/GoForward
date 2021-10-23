class GroupsController < ApplicationController
  def new
    @group = Group.new
    # @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    @group.leader_id = current_user.id
    @group.users << current_user
    if @group.password == ""
      @group.password = nil
    end
    
    if @group.save
      redirect_to user_path(current_user), notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    if @group.save
      flash[:notice] = "You have updated group successfully."
      redirect_to group_path(@group.id)
    else
      render :edit
    end
  end

  def show
    @group = Group.find(params[:id])
    @leader = User.find_by(id: @group.leader_id)
    
    @apply = Apply.find_by(group_id: @group.id, user_id: current_user.id)
    # 所属ユーザー一覧表示
    @group_users = GroupUser.where(group_id: @group.id)
    @users = []
    @group_users.each do |group_user|
      user = User.find_by(id: group_user.user_id)
      @users.push(user)
    end
    
  end
  
  def index
    @groups = Group.all
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to request.referer
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
