class PhrasesController < ApplicationController
  def show
  end

  def destroy
  end

  def edit
  end

  def update
  end

  def index
    @group = Group.find(params[:group_id])
  end

  def create
  end
end
