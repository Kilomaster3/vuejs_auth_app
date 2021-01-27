FactoryBot.define do
  factory :todo do
    title { Faker::Movies::StarWars.quote }
    user { Faker::Movies::StarWars.character }
  end
end
