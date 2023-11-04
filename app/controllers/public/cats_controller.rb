class Public::CatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
  end

  def edit
  end

  def confirm
  end

  def thanks
  end
end
