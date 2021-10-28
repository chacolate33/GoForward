class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @knowledge = Knowledge.find(params[:knowledge_id])
    favorite = Favorite.new(user_id: current_user.id, knowledge_id: @knowledge.id)
    favorite.save
  end
  
  def destroy
    @knowledge = Knowledge.find(params[:knowledge_id])
    favorite = Favorite.find_by(user_id: current_user.id, knowledge_id: @knowledge.id)
    favorite.destroy
  end
end
