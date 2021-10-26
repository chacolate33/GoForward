class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @value = params['value']
    @category = params['category']
    if @category == 'User'
      @users = User.search_for(@value) 
    elsif @category == 'Group'
      @groups = Group.search_for(@value)
    else 
      # ユーザーが所属するグループのフレーズから検索する
      @allphrases = Phrase.search_for(@value)
      @group_users = GroupUser.where(user_id: current_user.id)
      @phrases = []
      @group_users.each do |group_user|
        phrases = @allphrases.where(group_id: group_user.group_id)
        @phrases.concat(phrases)
      end
    end
  end
end
