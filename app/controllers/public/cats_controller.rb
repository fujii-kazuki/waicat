class Public::CatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cats = Cat.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def thanks
  end
end
