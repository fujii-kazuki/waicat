class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, if: :user_signed_in?

  def index
    @bookmark_cats =Kaminari.paginate_array(
      current_user.bookmarks.map { |bookmark| bookmark.cat }
    ).page(params[:page]).per(12)
    @current_page = @bookmark_cats.current_page
    @total_pages = @bookmark_cats.total_pages == 0 ? 1 : @bookmark_cats.total_pages
    @total_count = @bookmark_cats.total_count
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
