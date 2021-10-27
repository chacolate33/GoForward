class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @groups = Group.all
  end
end
