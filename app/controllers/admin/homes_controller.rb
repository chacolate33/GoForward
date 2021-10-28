class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    # グループ一覧表示
    @groups = Group.all.order(created_at: "DESC").page(params[:page]).per(20)
  end
end
