FactoryBot.define do
  factory :address do
    name { Faker::Address.street_name }
    email { Faker::Internet.email }
    street1 { Faker::Address.street_address }
    city { Faker::Address.city }
    province { Faker::Address.community }
    postal_code { Faker::Number.number(digits: 5) }
    contry_code { Faker::Number.number(digits: 2) }
  end
end
