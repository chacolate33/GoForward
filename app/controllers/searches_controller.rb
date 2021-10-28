class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @value = params['value']
    @category = params['category']
    # ユーザー一覧
    if @category == 'User'
      @users = User.search_for(@value).page(params[:page]).per(20)
    # グループ一覧
    elsif @category == 'Group'
      @groups = Group.search_for(@value).page(params[:page]).per(20)
    else
      # フレーズ一覧
      # ユーザーが所属するグループのフレーズから検索する
      @allphrases = Phrase.search_for(@value)
      @group_users = GroupUser.where(user_id: current_user.id)
      @phrases = []
      @group_users.each do |group_user|
        phrases = @allphrases.where(group_id: group_user.group_id)
        @phrases.concat(phrases)
      end
      @phrases = Kaminari.paginate_array(@phrases).page(params[:page]).per(20)
    end
  end
end
