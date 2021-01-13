class ItemsController < ApplicationController
  def index
  end

  def new
    if !user_signed_in?
      redirect_to root_path
    end
    @item = Item.new
  end
end
