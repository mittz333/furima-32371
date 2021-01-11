require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kana、
        birthdayが存在すれば登録できること" do
      expect(@user).to be_valid
    end

    it 'ニックネームが必須であること' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが必須であること' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = @user.email.gsub(/@/, '_at_')
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが必須であること' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは、半角英数字混合での入力が必須であること(数字のみ)' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    end

    it 'パスワードは、半角英数字混合での入力が必須であること(英字のみ)' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    end

    it 'パスワードは、半角英数字混合での入力が必須であること(全角では登録出来ないこと)' do
      @user.password = 'あいうえお１２３４５'
      @user.password_confirmation = 'あいうえお１２３４５'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    end

    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
      @user.password = 'a123456'
      @user.password_confirmation = 'a1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ユーザー本名は、名字と名前がそれぞれ必須であること(名字)' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'ユーザー本名は、名字と名前がそれぞれ必須であること(名前)' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること(名字)' do
      @user.last_name = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name 全角文字（漢字・ひらがな・カタカナ）を使用してください')
    end

    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること(名前)' do
      @user.first_name = 'def'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name 全角文字（漢字・ひらがな・カタカナ）を使用してください')
    end

    it 'ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること(名字)' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること(名前)' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること(名字)' do
      @user.last_name_kana = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana 全角文字（カタカナ）を使用してください')
    end

    it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること(名前)' do
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana 全角文字（カタカナ）を使用してください')
    end

    it '生年月日が必須であること' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
