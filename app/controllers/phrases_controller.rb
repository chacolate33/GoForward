class PhrasesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user

  # 所属グループ以外の投稿の閲覧・編集ができないようにする
  def ensure_current_user
    @group = Group.find(params[:group_id])
    unless GroupUser.exists?(group_id: @group.id, user_id: current_user.id)
      flash[:notice] = "Not authorized"
      redirect_to root_path
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @phrase = Phrase.new
    # 並び替え機能
    if params[:sort_abc]
      @phrases = Phrase.where(group_id: @group.id).order(content: "ASC")
    elsif params[:sort_aiu]
      @phrases = Phrase.where(group_id: @group.id).order(japanese: "ASC")
    elsif params[:sort_knowledge]
      @phrases = Phrase.where(group_id: @group.id).includes(:posted_phrases).sort {|a, b|
          b.posted_phrases.includes(:knowledges).size <=>
          a.posted_phrases.includes(:knowledges).size
        }
    elsif params[:sort_new]
      @phrases = Phrase.where(group_id: @group.id).order(created_at: "DESC")
    else
      @phrases = Phrase.where(group_id: @group.id)
    end
  end

  def show
    @phrase = Phrase.find(params[:id])
    @knowledge = Knowledge.new
    if params[:sort_favorite]
      @knowledges = Knowledge.where(phrase_id: @phrase.id).includes(:favorited_knowledges).sort {|a, b|
          b.favorited_knowledges.includes(:favorites).size <=>
          a.favorited_knowledges.includes(:favorites).size
        }
    elsif params[:sort_status]
      @knowledges = Knowledge.where(phrase_id: @phrase.id).order(:status)
    else
      @knowledges = Knowledge.where(phrase_id: @phrase.id).order(:status)
    end
  end

  def destroy
    @phrase = Phrase.find(params[:id])
    @phrase.destroy
    redirect_to request.referer
  end

  def edit
    @phrase = Phrase.find(params[:id])
    @content = @phrase.content
    @japanese = @phrase.japanese
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
