class Public::BookmarksController < ApplicationController
  def index
  end

  def create
    @cat = Cat.find(params[:cat_id])
    current_user.bookmarks.create(cat_id: params[:cat_id])
    flash.now[:notice] = 'ブックマークに登録しました。'
  end

  def destroy
    @cat = Cat.find(params[:id])
    current_user.bookmarks.find_by(cat_id: params[:id]).destroy
    flash.now[:notice] = 'ブックマークを解除しました。'
  end
end
