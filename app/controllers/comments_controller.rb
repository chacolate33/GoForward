class CommentsController < ApplicationController
  def create
    @knowledge = Knowledge.find(params[:knowledge_id])
    @comment = Comment.new
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.knowledge_id = @knowledge.id
    if @comment.save
      flash[:notice] = "You have created comment successfully."
      @comments = Comment.where(knowledge_id: @knowledge.id)
      # redirect_to request.referer
    else
      @knowledge = Knowledge.find(params[:knowledge_id])
      @phrase = Phrase.find_by(id: @knowledge.phrase_id)
      @comments = Comment.where(knowledge_id: @knowledge.id)
      # render 'knowledges/show'
    end
  end

  def destroy
    @knowledge = Knowledge.find(params[:knowledge_id])
    @comments = Comment.where(knowledge_id: @knowledge.id)
    @comment = Comment.find(params[:id])
    @comment.destroy
    # redirect_to request.referer
  end

  private
  def comment_params
    params.permit(:content)
  end
end
