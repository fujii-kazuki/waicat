class Public::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.invalid?
      render :new
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    case params[:commit]
    when '戻る' then
      render :new
    when '送信' then
      if @contact.save
        flash[:notice] = 'お問い合わせを受け付けました。'
        redirect_to root_path
      else
        render :new
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :body)
  end
end
