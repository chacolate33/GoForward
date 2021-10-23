class HomesController < ApplicationController
  def top
  end
  
  def myphrase
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end
end
