FactoryBot.define do
  factory :task do
    name { Faker::Lorem.word }
    source { Faker::Name.name }
    link { Faker::Internet.url }
    commentary { Faker::Lorem.sentence }
    lessons { FactoryBot.create_list(:lesson, 2) }
  end
end
