class MessagesController < ApplicationController
  before_action :authenticate_user!

  # DMのメッセージ作成
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      @room = Room.find(@message.room_id)
      if @message.save
        redirect_to room_path(@room)
      else
        @messages = @room.messages.order(created_at: "DESC").page(params[:page]).per(20)
        @entries = @room.entries
        render 'rooms/show'
      end
    else
      redirect_to request.referer
    end
  end
end
