class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
  def search
    @value = params['value']
    @category = params['category']
    if @category == 'User'
      @users = User.search_for(@value)
    elsif @category == 'Group'
      @groups = Group.search_for(@value)
    else
      @phrases = Phrase.search_for(@value)
    end
  end
end
