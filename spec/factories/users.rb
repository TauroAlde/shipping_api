FactoryBot.define do
  factory :user do
    name { Faker::Games::Pokemon.name }
    username { Faker::TvShows::GameOfThrones.character }
    email { Faker::Internet.email }
  end
end
