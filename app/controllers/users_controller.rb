class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:edit, :update]

  # 他ユーザーの情報を編集できないようにする
  def ensure_current_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "Not authorized"
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
    # 以下所属グループ一覧の記述
    @group_users = GroupUser.where(user_id: @user.id)
    @groups = []
    @group_users.each do |group_user|
      group = Group.find_by(id: group_user.group_id)
      @groups.push(group)
    end
    @groups = @user.groups.page(params[:page]).per(20)

    # 以下DM機能の記述
    # ログインしているユーザーが誰とDMでつながっているかを取得
    @currentUserEntry = Entry.where(user_id: current_user.id)
    # 表示しているユーザーが誰とDMでつながっているかを取得する
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      # 上の2つで取得したデータから、重複するroom番号があれば、ルームは存在し、そのidを付与する
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            # falseの時にroomを作成するための記述
            @isRoom = true
            @roomId = cu.room.id
          end
        end
      end
      # ルームがなければ(この画面に遷移した時にDMの部屋が存在しない場合)、それを作るための記述
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  # 退会確認画面
  def confirm
  end

  # 退会処理
  def leave
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "The withdrawral process has been executed."
    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated your infomation successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
