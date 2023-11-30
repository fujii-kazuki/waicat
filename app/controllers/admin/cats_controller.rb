class Admin::CatsController < ApplicationController
  def index
    if params[:user_id].blank?
      # パラメーターに会員IDが含まれていない場合
      @q = Cat.ransack(params[:q])
      @cats = @q.result.order(created_at: :desc).page(params[:page]).per(15)
    else
      @cats = Cat.where(user_id: params[:user_id]).order(created_at: :desc)
    end
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def leave
    cat = Cat.find(params[:cat_id])
    cat.update(deleted_flag: true)
    flash[:notice] = 'この掲載を削除しました。'
    redirect_to admin_cat_path(cat.id)
  end
end
