class PhrasesController < ApplicationController
  def show
    @phrase = Phrase.find(params[:id])
    @knowledges = Knowledge.where(phrase_id: @phrase.id).order(:status)
    @knowledge = Knowledge.new
  end

  def destroy
    @phrase = Phrase.find(params[:id])
    @phrase.destroy
    redirect_to request.referer
  end

  def edit
    @phrase = Phrase.find(params[:id])
  end

  def update
    @phrase = Phrase.find(params[:id])
    @phrase.update(phrase_params)
    if @phrase.save
      flash[:notice] = "You have updated phrase successfully."
      redirect_to group_phrases_path(group_id: @phrase.group_id)
    else
      render :edit
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @phrases = Phrase.where(group_id: @group.id)
    @phrase = Phrase.new
  end

  def create
    @group = Group.find(params[:group_id])
    @phrase = Phrase.new(phrase_params)
    @phrase.group_id = @group.id
    @phrase.user_id = current_user.id
    if @phrase.save
      flash[:notice] = "You have created phrase successfullly."
      redirect_to group_phrases_path(@group.id)
    else
      @phrases = Phrase.where(group_id: @group.id)
      render :index
    end
  end
  
  private 
  def phrase_params
    params.permit(:content, :japanese)
  end
end
