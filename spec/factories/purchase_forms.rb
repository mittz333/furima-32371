FactoryBot.define do
  factory :purchase_form do
    # zipcode { Faker::Number.between(from: 100, to: 999) + '-' + Faker::Number.between(from: 1000, to: 9999) }
    zipcode { '123-4567' }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    street_number { Faker::Address.street_address }
    building { Faker::Lorem.words }
    tel { Faker::Lorem.characters(number: 11, min_numeric: 11) }

    token {"tok_abcdefghijk00000000000000000"}
    # association :user
    # association :item
  end
end
