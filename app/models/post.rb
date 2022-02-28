class Post < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    validates :image,attached: true,content_type: ["image/png", "image/jpeg","image/jpg"]
    has_many :comments,dependent: :destroy
    has_many :likes,dependent: :destroy
end
