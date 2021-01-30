class PurchasesController < ApplicationController

  def index
    @purchaseform = PurchaseForm.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchaseform = PurchaseForm.new(purchase_params)
    @item = Item.find(purchase_params[:item_id])
    # binding.pry
    if @purchaseform.valid?
      @purchaseform.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  
  def purchase_params
    params.require(:purchase_form).permit(:zipcode, :prefecture_id, :city, :street_number, :building, :tel, :purchase).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
