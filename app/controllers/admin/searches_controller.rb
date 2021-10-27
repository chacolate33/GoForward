class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
  def search
    @value = params['value']
    @category = params['category']
    if @category == 'User'
      @users = User.search_for(@value).page(params[:page]).per(20)
    elsif @category == 'Group'
      @groups = Group.search_for(@value).page(params[:page]).per(20)
    else
      @phrases = Phrase.search_for(@value).page(params[:page]).per(20)
    end
  end
end
