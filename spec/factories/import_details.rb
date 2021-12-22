FactoryBot.define do
  factory :import_detail do
    uuid { SecureRandom.uuid }
    status { ImportDetail::PROCESSING }
  end
end
