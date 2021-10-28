class Admin::PhrasesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @group = Group.find(params[:group_id])
    # フレーズの並び替え機能
    # 英語のアルファベッド順
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
    else
      # デフォルト(古い順)
      @phrases = Phrase.where(group_id: @group.id)
    end
    @phrases = Kaminari.paginate_array(@phrases).page(params[:page]).per(20)
  end

  def show
    @phrase = Phrase.find(params[:id])
    # 知識の並び替え機能
    # いいねが多い順
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
  end

  def destroy
    @group = Group.find(params[:group_id])
    @phrase = Phrase.find(params[:id])
    @phrase.destroy
    redirect_to admin_group_phrases_path(group_id: @group.id)
  end
end
