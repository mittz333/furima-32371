class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :purchase
  has_many :comments ,dependent: :destroy

  validates :title, presence: true
  validates :detail, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :shipping_charge_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_days_id, presence: true
  validates :price, presence: true
  validates :image, presence: true
end
