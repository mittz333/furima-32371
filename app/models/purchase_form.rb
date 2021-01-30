class PurchaseForm

  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :zipcode, :prefecture_id, :city, :street_number, :building, :tel, :purchase

  with_options presence: true do
    validates :city
    validates :street_number
  end

  with_options presence: true, format: { with: /\A\d{3}[-]\d{4}\z/, message: '郵便番号は「-」を含む且つ7桁）を使用してください' } do
    validates :zipcode
  end
  with_options presence: true, format: { with: \d{,11}, message: '電話番号にはハイフンは不要で、11桁以内' } do
    validates :tel
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