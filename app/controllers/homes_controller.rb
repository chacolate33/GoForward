class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:myphrase]
  
  def top
  end

  def myphrase
    @bookmarks = Bookmark.where(user_id: current_user.id)
    # それぞれのブックマークに対応するフレーズを集める
    @phrases = []
    @bookmarks.each do |bookmark|
      phrase = bookmark.phrase
      @phrases.push(phrase)
    end
    # 並び替え機能
    # if params[:sort_abc]
    #   @phrases.sort_by{|array| array.content}
    # elsif params[:sort_aiu]
    #   @phrases.sort_by{|array| array.content}
    # elsif params[:sort_knowledge]
    #   @phrases.includes(:posted_phrases).sort {|a, b|
    #       b.posted_phrases.includes(:knowledges).size <=>
    #       a.posted_phrases.includes(:knowledges).size
    #     }
    # elsif params[:sort_new]
    #   @phrases.sort_by{|array| array.created_at}
    # else
      # 並び替え前の一覧画面 投稿が古い順
    # end
  end
end
