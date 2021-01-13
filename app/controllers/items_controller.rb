class ItemsController < ApplicationController
  def index
  end

  def new
    if !user_signed_in?
      redirect_to root_path
    end
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    # binding.pry
    params.require(:item).permit(:title, :detail, :category_id, :condition_id, :shipping_charge_id, :price, :image)
        .merge(user_id: current_user.id)
  end

end
