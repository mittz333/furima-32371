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
  # has_many :comments, dependent: :destroy
  # 将来的にitemsテーブルにぶら下がるcommentsテーブルが出来たら、上のように書くが、
  # 現時点ではcommentsテーブル無いので、下のように書く。
  # 下のように書かないと、itemを削除する際にエラーになる。
  has_many :comments

  with_options presence: true do
    validates :title
    validates :detail
    validates :image
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :condition_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :shipping_day_id
    validates :category_id
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
