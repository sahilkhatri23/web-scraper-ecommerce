FactoryBot.define do
    factory :seller do
      name { Faker::Company.name }
      rating { Faker::Number.between(from: 0.0, to: 5.0) }
      policy { Faker::Lorem.sentence }
      additional_info { Faker::Lorem.paragraph }
    end
  end
  