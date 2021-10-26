class Admin::KnowledgesController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @knowledge = Knowledge.find(params[:id])
    @phrase = Phrase.find_by(id: @knowledge.phrase_id)
    @comments = Comment.where(knowledge_id: @knowledge.id)
  end
end
