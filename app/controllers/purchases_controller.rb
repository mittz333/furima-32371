class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :is_purchase, only: [:index, :create]

  # コミット行うため、ダミーの行を追加
  
  def index
    @purchaseform = PurchaseForm.new
    if @item.purchase != nil || @item.user_id == current_user.id
      redirect_to root_path
    end    
  end

  def create
    @purchaseform = PurchaseForm.new(purchase_params)
    if @purchaseform.valid?
      pay_item
      @purchaseform.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:zipcode, :prefecture_id, :city, :street_number, :building, :tel, :purchase).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def is_purchase
    if @item.purchase != nil || @item.user_id == current_user.id
      redirect_to root_path
    end    
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

end
