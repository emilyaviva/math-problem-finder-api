FactoryBot.define do
  factory :lesson do
    name { Faker::Lorem.word }
    summary { Faker::Lorem.sentence }
    category { FactoryBot.create(:category) }
  end
end
