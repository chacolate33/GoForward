class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @phrase = Phrase.find(params[:phrase_id])
    bookmark = Bookmark.new(user_id: current_user.id, phrase_id: @phrase.id)
    bookmark.save
    redirect_to request.referer
  end

  def destroy
    @phrase = Phrase.find(params[:phrase_id])
    bookmark = Bookmark.find_by(user_id: current_user.id, phrase_id: @phrase.id)
    bookmark.destroy
    redirect_to request.referer
  end
end
