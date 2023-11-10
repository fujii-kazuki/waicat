class Public::CandidatesController < ApplicationController
  def confirm
    @cat = Cat.find(params[:cat_id])
  end
end
