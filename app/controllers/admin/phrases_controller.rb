class Admin::PhrasesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @phrases = Phrase.where(group_id: @group.id)
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
  end
end
