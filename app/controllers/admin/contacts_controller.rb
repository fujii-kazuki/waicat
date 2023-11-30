class Admin::ContactsController < ApplicationController
  def index
    @q = Contact.ransack(params[:q])
    @contacts = @q.result.order(created_at: :desc).page(params[:page]).per(15)
  end

  def new
  end
end
