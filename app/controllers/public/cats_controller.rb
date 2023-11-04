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

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    @cat.publication_date = Time.zone.now
    @cat.publication_status = 1

    if params[:back]
      render :new
    else
      @cat.save
      flash[:notice] = '掲載が完了しました。'
      redirect_to cat_path(@cat.id)
    end
  end

  def edit
  end

  def confirm
    @cat = Cat.new(cat_params)

    # 仮ステータス
    @cat.user_id = 1
    @cat.publication_date = Time.zone.now
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
