class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  # 検索機能
  def search
    @value = params['value']
    @category = params['category']
    # ユーザー一覧
    if @category == 'User'
      @users = User.search_for(@value).page(params[:page]).per(20)
    # グループ一覧
    elsif @category == 'Group'
      @groups = Group.search_for(@value).page(params[:page]).per(20)
    # フレーズ一覧
    else
      @phrases = Phrase.search_for(@value).page(params[:page]).per(20)
    end
  end
end
