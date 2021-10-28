class Admin::CommentsController < ApplicationController
  def destroy
    @knowledge = Knowledge.find(params[:knowledge_id])
    @comments = Comment.where(knowledge_id: @knowledge.id).page(params[:page]).per(20)
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
