class Admin::CatsController < ApplicationController
  def index
    @cats = Cat.all.order(created_at: :desc)
  end

  def show
  end
end
