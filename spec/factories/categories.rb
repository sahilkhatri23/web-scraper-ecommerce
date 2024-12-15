FactoryBot.define do
    factory :category do
      name { Faker::Commerce.department }
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.png'), 'image/jpeg') }
  
      trait :with_image do
        image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.png'), 'image/jpeg') }
      end
    end
  end
  