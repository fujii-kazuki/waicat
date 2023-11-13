class Admin::CatsController < ApplicationController
  def index
    # パラメーターに会員IDが含まれているか
    if params[:user_id].blank?
      @cats = Cat.all.order(created_at: :desc)
    else
      @cats = Cat.where(user_id: params[:user_id]).order(created_at: :desc)
    end
  end

  def show
    @cat = Cat.find(params[:id])
  end
end
