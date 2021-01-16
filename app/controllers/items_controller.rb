class ItemsController < ApplicationController
  def index
  end

  def new
    # redirect_to root_path unless user_signed_in? 未ログイン時、トップページではなくログインページに飛ぶように変更
    redirect_to new_user_session_path unless user_signed_in?
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
    params.require(:item).permit(:title, :detail, :category_id, :condition_id, :shipping_charge_id,
                                 :prefecture_id, :shipping_day_id, :price, :image)
          .merge(user_id: current_user.id)
  end
end
