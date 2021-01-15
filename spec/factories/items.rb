FactoryBot.define do
  factory :item do
    category_id { Faker::Number.between(from: 1, to: 10) }
    condition_id { Faker::Number.between(from: 1, to: 6) }
    shipping_charge_id { Faker::Number.between(from: 1, to: 2) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    shipping_day_id { Faker::Number.between(from: 1, to: 3) }
    title { Faker::Lorem.word }
    detail { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    # image { Faker::Lorem.sentence }
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    association :user
  end
end
