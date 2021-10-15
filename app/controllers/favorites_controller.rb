class FavoritesController < ApplicationController
  def create
    knowledge = Knowledge.find(params[:knowledge_id])
    favorite = Favorite.new(user_id: current_user.id, knowledge_id: knowledge.id)
    favorite.save
    redirect_to request.referer
  end
  
  def destroy
    knowledge = Knowledge.find(params[:knowledge_id])
    favorite = Favorite.find_by(user_id: current_user.id, knowledge_id: knowledge.id)
    favorite.destroy
    redirect_to request.referer
  end
end
