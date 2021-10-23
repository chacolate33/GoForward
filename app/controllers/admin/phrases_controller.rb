class Admin::PhrasesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @phrases = Phrase.where(group_id: @group.id)
  end

  def show
    @phrase = Phrase.find(params[:id])
    @knowledges = Knowledge.where(phrase_id: @phrase.id)
  end
end
