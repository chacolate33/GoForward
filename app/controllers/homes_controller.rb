class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:myphrase]

  def top
  end

  # ブックマーク一覧
  def myphrase
    @bookmarks = Bookmark.where(user_id: current_user.id)
    # それぞれのブックマークに対応するフレーズを集める
    @phrases = []
    @bookmarks.each do |bookmark|
      phrase = bookmark.phrase
      @phrases.push(phrase)
    end

    @phrases = Kaminari.paginate_array(@phrases).page(params[:page]).per(20)
  end
end
