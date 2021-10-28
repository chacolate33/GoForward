class Admin::PhrasesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @group = Group.find(params[:group_id])
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
    @phrases = Kaminari.paginate_array(@phrases).page(params[:page]).per(20)
  end

  def show
    @phrase = Phrase.find(params[:id])
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
    @knowledges = Kaminari.paginate_array(@knowledges).page(params[:page]).per(20)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @phrase = Phrase.find(params[:id])
    @phrase.destroy
    redirect_to admin_group_phrases_path(group_id: @group.id)
  end
end
