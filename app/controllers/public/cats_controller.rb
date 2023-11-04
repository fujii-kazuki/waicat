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
    
    # 戻るリンクを選択した場合
    if params[:back_new]
      render :new
    else
      @cat.user_id = current_user.id
      @cat.publication_date = Time.zone.now
      @cat.publication_status = 1
      @cat.save
      flash[:notice] = '掲載が完了しました。'
      redirect_to cat_path(@cat.id)
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    
    # 戻るリンクを選択した場合
    if params[:back_edit]
      set_params(@cat)
      render :edit
    else
      @cat.update(cat_params)
      flash[:notice] = '掲載の更新が完了しました。'
      redirect_to cat_path(@cat.id)
    end
  end

  def confirm
    # 新規掲載フォームからの確認の場合
    if params[:new]
      @cat = Cat.new(cat_params)
      if @cat.invalid?
        render :new
      end

    # 掲載編集フォームからの確認の場合
    elsif params[:edit]
      @cat = Cat.find(params[:cat][:id])
      set_params(@cat)
      if @cat.invalid?
        render :edit
      end
    end
  end

  def destroy
    Cat.find(params[:id]).destroy
    flash[:notice] = '掲載を削除しました。'
    redirect_to cats_path
  end

  private
  
  # ストロングパラメーター
  def cat_params
    params.require(:cat).permit(
      :user_id,
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
      :publication_date,
      :publication_deadline,
      :publication_status
    )
  end

  def set_params(cat)
    cat.publication_title = params[:cat][:publication_title]
    cat.name = params[:cat][:name]
    cat.age = params[:cat][:age]
    cat.gender = params[:cat][:gender]
    cat.weight = params[:cat][:weight]
    cat.breed = params[:cat][:breed]
    cat.animal_print = params[:cat][:animal_print]
    cat.hair_length = params[:cat][:hair_length]
    cat.castration_flag = params[:cat][:castration_flag]
    cat.vaccine_flag = params[:cat][:vaccine_flag]
    cat.postal_code = params[:cat][:postal_code]
    cat.prefecture = params[:cat][:prefecture]
    cat.municipalitie = params[:cat][:municipalitie]
    cat.background = params[:cat][:background]
    cat.personality = params[:cat][:personality]
    cat.health = params[:cat][:health]
    cat.delivery_place = params[:cat][:delivery_place]
    cat.remarks = params[:cat][:remarks]
    cat.publication_deadline = params[:cat][:publication_deadline]
  end
end
