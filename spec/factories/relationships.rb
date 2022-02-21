FactoryBot.define do
    factory :Relationship do
        follower factory: :user, email: "example1@gmail.com"
        followed factory: :user,email: "example2@gmail.com"
    end
  end