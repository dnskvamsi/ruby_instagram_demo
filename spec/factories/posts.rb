FactoryBot.define do
    factory :post do
        title {"My string"}
        description {"My String"}
        location {"My String"}
        association :user
        after(:build) do |post|
            post.image.attach(io: File.open('spec/test_image/1.jpeg'), filename: '1.jpeg', content_type: 'image/jpeg')
          end
    end
end