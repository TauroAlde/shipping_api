FactoryBot.define do
  factory :order do
    reference { Faker::Address.city_suffix }
  end
end
