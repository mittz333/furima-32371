FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    # password = Faker::Internet.password(min_length: 6) 英数字混在しない可能性あるので以下に変更
    password = Faker::Lorem.characters(number: 10, min_alpha: 1, min_numeric: 1)
    password { password }
    password_confirmation { password }

    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birthday { Date.new(1993, 2, 24) }
  end
end
