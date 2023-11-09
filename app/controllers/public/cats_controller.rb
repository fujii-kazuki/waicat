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
    @cat = current_user.cats.new(cat_params)
    
    # 戻るリンクを選択した場合
    if params[:back_new]
      render :new
    else
      @cat.publication_status = 'public'
      @cat.publication_date = Time.zone.now
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
    @cat.assign_attributes(cat_params) # attributeを変更（DBへの保存は行われない）
    
    # 戻るリンクを選択した場合
    if params[:back_edit]
      render :edit
    else
      @cat.publication_status = 'public'
      @cat.save
      flash[:notice] = '掲載の更新が完了しました。'
      redirect_to cat_path(@cat.id)
    end
  end

  def confirm
    # 新規掲載フォームからの下書き保存の場合
    if params[:new_draft]
      @cat = current_user.cats.new(cat_params)
      @cat.publication_date = Time.zone.now
      @cat.publication_status = 'draft'
      if @cat.invalid?
        render :new
      else
        @cat.save
        flash[:notice] = '下書き保存が完了しました。'
        redirect_to cats_path
      end

    # 新規掲載フォームからの確認の場合
    elsif params[:new]
      @cat = current_user.cats.new(cat_params)
      @cat.publication_date = Time.zone.now
      @cat.publication_status = 'public'
      if @cat.invalid?
        render :new
      end

    # 掲載編集フォームからの下書き保存の場合
    elsif params[:edit_draft]
      @cat = Cat.find(params[:cat][:id])
      @cat.assign_attributes(cat_params) # attributeを変更（DBへの保存は行われない）
      @cat.publication_status = 'draft'
      if @cat.invalid?
        render :edit
      else
        @cat.save
        flash[:notice] = '下書き保存が完了しました。'
        redirect_to cats_path
      end

    # 掲載編集フォームからの確認の場合
    elsif params[:edit]
      @cat = Cat.find(params[:cat][:id])
      @cat.assign_attributes(cat_params) # attributeを変更（DBへの保存は行われない）
      @cat.publication_status = 'public'
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
      :video,
      { photos: [] },
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
      :city,
      :background,
      :personality,
      :health,
      :delivery_place,
      :remarks,
      :publication_deadline,
      :publication_status
    )
  end
end
