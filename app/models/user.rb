# email :string
# password_digest : string
# password: string virtual (attr)
# password_confirmation : string virtual (attr)
class User < ApplicationRecord
    has_secure_password
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,presence: true,format: {with: VALID_EMAIL_REGEX, message: "Must be a valid email address" }
    validates :email,:uniqueness => { message: " already exists",:case_sensitive => false }
    has_many :posts,dependent: :destroy 
    has_many :comments
    has_many :following,foreign_key: "follower_id",class_name: "Relationship"
    has_many :followers,foreign_key: "followed_id",class_name: "Relationship"
    has_many :likes,dependent: :destroy
end
