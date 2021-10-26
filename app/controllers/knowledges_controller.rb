class KnowledgesController < ApplicationController
  def new
  end

  def create
    @phrase = Phrase.find(params[:phrase_id])
    @knowledge = Knowledge.new(knowledge_params)
    @knowledge.user_id = current_user.id
    @knowledge.phrase_id = @phrase.id
    if @knowledge.save
      flash[:notice] = "You have created knowledge successfully."
      redirect_to group_phrase_path(id: @phrase.id)
    else
      @phrase = Phrase.find(params[:phrase_id])
      @knowledges = Knowledge.where(phrase_id: @phrase.id)
      render 'phrases/show'
    end

  end

  def edit
    @knowledge = Knowledge.find(params[:id])
    @content = @knowledge.content
    @genre = @knowledge.status
  end

  def update
    @knowledge = Knowledge.find(params[:id])
    @knowledge.update(knowledge_params)
    if @knowledge.save
      flash[:notice] = "You have updated phrase successfully."
      redirect_to group_phrase_path(group_id: @knowledge.phrase.group_id, id: @knowledge.phrase.id)
    else
      render :edit
    end
  end

  def show
    @knowledge = Knowledge.find(params[:id])
    @phrase = Phrase.find_by(id: @knowledge.phrase_id)
    @comment = Comment.new
    @comments = Comment.where(knowledge_id: @knowledge.id)
  end

  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    redirect_to request.referer

  end

  private

  def knowledge_params
    params.permit(:content, :status)
  end

end
