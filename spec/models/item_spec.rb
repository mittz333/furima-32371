require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    it "titleとdetail、category_idとcondition_id、shipping_charge_idとprefecture_id、prefecture_idとshipping_day_id、
        priceとimageとuser_idが存在すれば登録できること" do
      expect(@item).to be_valid
    end

    it '商品名が必須であること' do
      @item.title = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Title can't be blank")
    end

    it '商品の説明が必須であること' do
      @item.detail = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Detail can't be blank")
    end

    it 'カテゴリーが必須であること(0ではない)' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 0')
    end

    it '商品の状態が必須であること(0ではない)' do
      @item.condition_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition must be other than 0')
    end

    it '配送料の負担が必須であること(0ではない)' do
      @item.shipping_charge_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping charge must be other than 0')
    end

    it '発送元の地域が必須であること(0ではない)' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
    end

    it '発送までの日数が必須であること(0ではない)' do
      @item.shipping_day_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping day must be other than 0')
    end

    it '価格が必須であること' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end

    it '価格が適正な数値であること(300〜9,999,999)(300未満）' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が適正な数値であること(300〜9,999,999)(9999999より大きい)' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it '販売価格は半角数字での入力が必須であること(全角では登録出来ないこと)' do
      @item.price = '１２３４５'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end

    it '画像が必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it 'ユーザーが必須であること' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end
