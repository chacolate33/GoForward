class KnowledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user

  # 所属グループ以外の投稿の閲覧、編集ができないようにする
  def ensure_current_user
    @group = Group.find(params[:group_id])
    unless GroupUser.exists?(group_id: @group.id, user_id: current_user.id)
      flash[:notice] = "Not authorized"
      redirect_to root_path
    end
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
      @knowledges = Knowledge.where(phrase_id: @phrase.id).page(params[:page]).per(20)
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
    @phrase = Phrase.find(params[:phrase_id])
    # 表示するべき知識があれば詳細画面を表示
    if Knowledge.exists?(params[:id])
      @knowledge = Knowledge.find(params[:id])
      @comment = Comment.new
      # 知識に対するコメント一覧
      @comments = Comment.where(knowledge_id: @knowledge.id).page(params[:page]).per(20)
    else
      # 知識を削除した後にその詳細画面に戻った際のエラーを防ぐ
      @group = Group.find(params[:group_id])
      @knowledges = Knowledge.where(phrase_id: @phrase.id).order(:status)
      @knowledges = Kaminari.paginate_array(@knowledges).page(params[:page]).per(20)
      redirect_to group_phrase_knowledges_path(group_id: @group.id, id: @phrase.id)
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @phrase = Phrase.find(params[:phrase_id])
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    redirect_to group_phrase_path(group_id: @group.id, id: @phrase.id)
  end

  private

  def knowledge_params
    params.permit(:content, :status)
  end
end
