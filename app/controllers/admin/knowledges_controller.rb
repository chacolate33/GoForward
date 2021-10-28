class Admin::KnowledgesController < ApplicationController
  before_action :authenticate_admin!

  def show
    @knowledge = Knowledge.find(params[:id])
    @phrase = Phrase.find_by(id: @knowledge.phrase_id)
    # 知識に紐づいたコメント一覧
    @comments = Comment.where(knowledge_id: @knowledge.id).page(params[:page]).per(20)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @phrase = Phrase.find(params[:phrase_id])
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    redirect_to admin_group_phrase_path(group_id: @group.id, id: @phrase.id)
  end
end
