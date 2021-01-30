class PurchaseForm

  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :zipcode, :prefecture_id, :city, :street_number, :building, :tel, :purchase

  with_options presence: true do
    validates :zipcode
    validates :city
    validates :street_number
    validates :tel
    validates :street_number
  end

  with_options numericality: { other_than: 0 } do
    validates :prefecture_id
  end

  def save
    # binding.pry
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(zipcode: zipcode, prefecture_id: prefecture_id, city: city, street_number: street_number, building: building, tel: tel, purchase_id: purchase.id)
  end

end