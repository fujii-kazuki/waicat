class Public::HomesController < ApplicationController
  def top
    @featured_cats = Cat.where(
      publication_status: 'public',
      deleted_flag: false
    ).order(publication_deadline: :asc).limit(9)
  end

  def about
  end
end
