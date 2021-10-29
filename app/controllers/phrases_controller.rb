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
    # フレーズのアルファベッド順
    if params[:sort_abc]
      @phrases = Phrase.where(group_id: @group.id).order(content: "ASC")
    # 和訳の五十音順
    elsif params[:sort_aiu]
      @phrases = Phrase.where(group_id: @group.id).order(japanese: "ASC")
    # 投稿知識の多さで並び替え
    elsif params[:sort_knowledge]
      @phrases = Phrase.where(group_id: @group.id).includes(:posted_phrases).sort do |a, b|
        b.posted_phrases.includes(:knowledges).size <=>
        a.posted_phrases.includes(:knowledges).size
      end
    # 新しい順
    elsif params[:sort_new]
      @phrases = Phrase.where(group_id: @group.id).order(created_at: "DESC")
    # デフォルト(古い順)
    else
      @phrases = Phrase.where(group_id: @group.id)
    end
    @phrases = Kaminari.paginate_array(@phrases).page(params[:page]).per(20)
  end

  def show
    # 表示すべきphraseがあればページを表示
    if Phrase.exists?(params[:id])
      @phrase = Phrase.find(params[:id])
      # 知識の並び替え機能
      # いいねが多い順
      @knowledge = Knowledge.new
      if params[:sort_favorite]
        @knowledges = Knowledge.where(phrase_id: @phrase.id).includes(:favorited_knowledges).sort do |a, b|
          b.favorited_knowledges.includes(:favorites).size <=>
          a.favorited_knowledges.includes(:favorites).size
        end
      # デフォルト(ステータスごと)
      elsif params[:sort_status]
        @knowledges = Knowledge.where(phrase_id: @phrase.id).order(:status)
      else
        @knowledges = Knowledge.where(phrase_id: @phrase.id).order(:status)
      end
      @knowledges = Kaminari.paginate_array(@knowledges).page(params[:page]).per(20)
    else
      # プレーズを削除して、それが存在しない場合は、フレーズ一覧に遷移してエラーを防ぐ
      @group = Group.find(params[:group_id])
      redirect_to group_phrases_path(@group)
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @phrase = Phrase.find(params[:id])
    @phrase.destroy
    redirect_to group_phrases_path(group_id: @group.id)
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
      @phrases = Kaminari.paginate_array(@phrases).page(params[:page]).per(20)
      render :index
    end
  end

  private

  def phrase_params
    params.permit(:content, :japanese)
  end
end
