FactoryBot.define do
  factory :address do
    zipcode { '123-4567' }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    street_number { Faker::Address.street_address }
    building { Faker::Lorem.words }
    tel { Faker::Lorem.characters(number: 11, min_numeric: 11) }
    association :purchase
  end
end
