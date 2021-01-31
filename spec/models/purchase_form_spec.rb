require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchaseform = FactoryBot.build(:purchase_form, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@purchaseform).to be_valid
    end

    it '建物名が抜けていても登録できること' do
      @purchaseform.building = nil
      expect(@purchaseform).to be_valid
    end

    it '郵便番号が必須であること' do
      @purchaseform.zipcode = nil
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include("Zipcode can't be blank")
    end

    it '都道府県が必須であること(0ではない)' do
      @purchaseform.prefecture_id = 0
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include('Prefecture must be other than 0')
    end

    it '市区町村が必須であること' do
      @purchaseform.city = nil
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include("City can't be blank")
    end

    it '番地が必須であること' do
      @purchaseform.street_number = nil
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include("Street number can't be blank")
    end

    it '電話番号が必須であること' do
      @purchaseform.tel = nil
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include("Tel can't be blank")
    end

    it '郵便番号にはハイフンが必要であること(123-4567となる)' do
      @purchaseform.zipcode = '1234567'
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include('Zipcode 郵便番号は「-」を含む且つ7桁）を使用してください')
    end

    it '電話番号にはハイフンは不要で、11桁以内であること（09012345678となる）' do
      @purchaseform.tel = '0123-456-7890'
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include('Tel 電話番号にはハイフンは不要で、11桁以内')
    end

    it 'ユーザーが必須であること' do
      @purchaseform.user_id = nil
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include("User can't be blank")
    end

    it '商品が必須であること' do
      @purchaseform.item_id = nil
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include("Item can't be blank")
    end

    it 'tokenが必須であること' do
      @purchaseform.token = nil
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include("Token can't be blank")
    end

    it '電話番号は全角数字だと登録できないこと' do
      @purchaseform.tel = '０１２３-４５６-７８９０'
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include('Tel 電話番号にはハイフンは不要で、11桁以内')
    end
    
    it '電話番号は12桁以上だと登録できないこと' do
      @purchaseform.tel = '012345678901'
      @purchaseform.valid?
      expect(@purchaseform.errors.full_messages).to include('Tel 電話番号にはハイフンは不要で、11桁以内')
    end

  end
end
