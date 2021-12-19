FactoryBot.define do
  factory :shipment do

    trait :with_order do
      order { create(:order) }
    end

    trait :with_address_from do
      address_from { create(:address) }
    end

    trait :with_address_to do
      address_to { create(:address) }
    end
  end
end
