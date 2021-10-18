class Admin::HomesController < ApplicationController
  def top
    @groups = Group.all
  end
end
