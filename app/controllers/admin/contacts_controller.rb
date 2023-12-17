class Admin::ContactsController < ApplicationController
  def index
    @q = Contact.ransack(params[:q])
    @contacts = @q.result.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def read
    @contact = Contact.find(params[:id])
    @contact.update(readed_flag: true)
    flash.now[:success] = 'このお問い合せを「確認済み」状態に変更しました。'
  end
end
