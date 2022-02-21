FactoryBot.define do
    factory :comment do
        content {"My comment"}
        association :user
        association :post
    end
end