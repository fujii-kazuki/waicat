class Public::CatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def edit
  end

  def confirm
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    @cat.publication_date = Time.zone.now  # 仮の掲載日
    @cat.publication_status = 0

    if @cat.invalid?
      render :new
    end
  end

  def thanks
  end

  private
  
  # ストロングパラメーター
  def cat_params
    params.require(:cat).permit(
      :publication_title,
      :name,
      :age,
      :gender,
      :weight,
      :breed,
      :animal_print,
      :hair_length,
      :castration_flag,
      :vaccine_flag,
      :postal_code,
      :prefecture,
      :municipalitie,
      :background,
      :personality,
      :health,
      :delivery_place,
      :remarks,
      :publication_deadline
    )
  end
end
