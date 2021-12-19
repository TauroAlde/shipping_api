FactoryBot.define do
  factory :parcel do
    lenght { Faker::Number.number(digits: 3) }
    width { Faker::Number.number(digits: 3) }
    height { Faker::Number.number(digits: 3) }
    weight { Faker::Number.number(digits: 3) }

    trait :with_shipment do
      shipment { create(:shipment, :with_address_from, :with_address_to) }
    end

    trait :with_feed_dimension_unit do
      dimension_unit { "Ft" }
    end

    trait :with_centimeter_dimension_unit do
      dimension_unit { "Cm" }
    end

    trait :with_kilogram_weight_unit do
      weight_unit { "Kg" }
    end

    trait :with_pound_weight_unit do
      weight_unit { "Lb" }
    end
  end
end
