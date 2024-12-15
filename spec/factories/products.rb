FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    url { "http://example.com" }
    category { create(:category) }
    seller { create(:seller) }
  end
end
