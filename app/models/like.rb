class Like < ApplicationRecord
  validates :user_id,uniqueness: {scope: :post_id}
  belongs_to :user
  belongs_to :post
  after_save {broadcast_update_to "post_#{self.post_id}".to_sym, partial: "shared/likes", locals: { post: Post.find(self.post_id) }}
end
