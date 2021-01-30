class PurchasesController < ApplicationController

  def index
    @purchaseform = PurchaseForm.new
    @item = Item.find(params[:item_id])
  end

  def create
    # binding.pry
    @purchaseform = PurchaseForm.new(purchase_params)
    if @purchaseform.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  
  def purchase_params
    params.require(:purchase_form).permit(:zipcode, :prefecture_id, :city, :street_number, :building, :tel, :purchase).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
