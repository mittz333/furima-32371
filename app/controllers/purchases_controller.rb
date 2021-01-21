class PurchasesController < ApplicationController

  private
  def purchase_params
    params.require(:purcase).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
