FactoryBot.define do
  factory :post do
    body { Faker::Lorem.characters(number:20) }
    user
  end
end