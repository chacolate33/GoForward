class Admin::KnowledgesController < ApplicationController
  before_action :authenticate_admin!

  def show
    # 知識に紐づいたフレーズが削除されていないか確かめる。
    if Phrase.exists?(params[:phrase_id])
      @phrase = Phrase.find(params[:phrase_id])
      # 表示するべき知識があれば詳細画面を表示
      if Knowledge.exists?(params[:id])
        @knowledge = Knowledge.find(params[:id])
        # 知識に紐づいたコメント一覧
        @comments = Comment.where(knowledge_id: @knowledge.id).page(params[:page]).per(20)
      else
        # 知識を削除した後にその詳細画面に戻った際のエラーを防ぐ
        @group = Group.find(params[:group_id])
        @knowledges = Knowledge.where(phrase_id: @phrase.id).order(:status)
        @knowledges = Kaminari.paginate_array(@knowledges).page(params[:page]).per(20)
        redirect_to admin_group_phrase_path(group_id: @group.id, id: @phrase.id)
      end
    else
      # フレーズがなければフレーズの一覧画面に遷移
      @group = Group.find(params[:group_id])
      redirect_to admin_group_phrases_path(@group)
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @phrase = Phrase.find(params[:phrase_id])
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    redirect_to admin_group_phrase_path(group_id: @group.id, id: @phrase.id)
  end
end
