class RoomsController < ApplicationController
  before_action :authenticate_user!
  # DMをする2人の部屋を作る
  def create
    @room = Room.create(params.require(:room).permit(:user_id))
    # ログインしているユーザーを保存する
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    # 相手の情報を保存する。room_idはviewから取得していないので、追加で取得
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room)
  end

  # DMのメッセージ一覧を表示する
  def show
    @room = Room.find(params[:id])
      # ログインしているユーザーがRoomの一員であるか確認
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.order(created_at: "DESC").page(params[:page]).per(20)
      @message = Message.new
      @entries = @room.entries
    else
      # 権限がないのでtop
      redirect_to root_path
    end
  end
end
