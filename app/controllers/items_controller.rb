class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show]

  def index
    @items = Item.order(created_at: 'DESC')
  end

  def new
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

  def show
  end

  def edit
    redirect_to root_path unless user_signed_in? && current_user.id == @item.user_id
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to item_path(params[:id])
    else
      @item = item
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :detail, :category_id, :condition_id, :shipping_charge_id,
                                 :prefecture_id, :shipping_day_id, :price, :image)
          .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
