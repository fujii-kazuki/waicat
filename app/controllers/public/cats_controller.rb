class Public::CatsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, except: [:index, :show], if: :user_signed_in?

  def index
    @cats = Cat.where(
      publication_status: ['public', 'in_consultation', 'foster_parents_decided', 'recruitment_closed'],
      deleted_flag: false
    ).order(created_at: :desc).page(params[:page]).per(12)
    @current_page = @cats.current_page
    @total_pages = @cats.total_pages == 0 ? 1 : @cats.total_pages
    @total_count = @cats.total_count
  end

  def show
    @cat = Cat.find(params[:id])
    # 掲載が表示可能か判定
    if !current_user?(@cat.user) &&
       ( @cat.deleted_flag ||
       @cat.publication_status == 'draft' ||
       @cat.publication_status == 'private' )

      flash[:alert] = '指定の掲載は非表示か、削除された可能性があります。'
      redirect_to cats_path
    end
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
      @cat.video = nil if params[:cat][:video].nil?
      @cat.publication_status = 'public'
      @cat.publication_date = Time.zone.now
      if @cat.save
        flash[:success] = '掲載が完了しました。'
        redirect_to cat_path(@cat.id)
      else
        render :new
      end
    end
  end

  def edit
    @cat = Cat.find(params[:id])

    # 掲載が編集可能か判定
    if @cat.user.id != current_user.id ||
       @cat.publication_status == 'in_consultation' ||
       @cat.publication_status == 'foster_parents_decided' ||
       @cat.publication_status == 'recruitment_closed' 

      redirect_to cat_path(@cat.id)
    end
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.assign_attributes(cat_params) # attributeを変更（DBへの保存は行われない）
    
    # 戻るリンクを選択した場合
    if params[:back_edit]
      render :edit
    else
      @cat.video = nil if params[:cat][:video].nil?
      @cat.publication_status = 'public'
      if @cat.save
        flash[:success] = '掲載の更新が完了しました。'
        redirect_to cat_path(@cat.id)
      else
        render :edit
      end
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
        flash[:success] = '下書き保存が完了しました。'
        redirect_to cat_path(@cat.id)
      end

    # 新規掲載フォームからの確認の場合
    elsif params[:new]
      @cat = current_user.cats.new(cat_params)
      @cat.publication_date = Time.zone.now
      @cat.publication_status = 'public'
      if @cat.invalid?
        render :new
      else
        flash[:warn] = '掲載内容を確認してください。'
      end

    # 掲載編集フォームからの下書き保存の場合
    elsif params[:edit_draft]
      @cat = Cat.find(params[:cat][:id])
      @cat.assign_attributes(cat_params) # attributeを変更（DBへの保存は行われない）
      if @cat.invalid?
        render :edit
      else
        @cat.photos = nil if params[:cat][:photos].nil?
        @cat.video = nil if params[:cat][:video].nil?
        @cat.save
        flash[:success] = '下書き保存が完了しました。'
        redirect_to cat_path(@cat.id)
      end

    # 掲載編集フォームからの確認の場合
    elsif params[:edit]
      @cat = Cat.find(params[:cat][:id])
      @cat.assign_attributes(cat_params) # attributeを変更（DBへの保存は行われない）
      @cat.publication_status = 'public'
      if @cat.invalid?
        render :edit
      else
        flash[:warn] = '掲載内容を確認してください。'
      end
    end
  end

  def destroy
    Cat.find(params[:id]).update(deleted_flag: true)
    flash[:notice] = '掲載を削除しました。'
    redirect_to user_path(current_user.id)
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
