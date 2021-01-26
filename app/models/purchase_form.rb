class PurchaseForm

  include ActiveModel::Model
  attr_accessor :item, :user, :zipcode, :prefecture_id, :city, :street_number, :building, :tel, :purchase

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
    # 各テーブルにデータを保存する処理を書く
  end