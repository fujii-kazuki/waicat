class Public::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
end
