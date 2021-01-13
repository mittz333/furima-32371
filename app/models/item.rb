class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :shipping_day

  belongs_to :user
  has_one_attached :image
  has_one :purchase
  has_many :comments ,dependent: :destroy

  validates :title, presence: true
  validates :detail, presence: true
  validates :category_id, numericality: { other_than: 0 } 
  validates :condition_id, numericality: { other_than: 0 } 
  validates :shipping_charge_id, numericality: { other_than: 0 } 
  validates :prefecture_id, numericality: { other_than: 0 } 
  validates :shipping_day_id, numericality: { other_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to:9999999 }
  validates :image, presence: true

end
