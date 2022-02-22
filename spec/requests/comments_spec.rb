require 'rails_helper'

RSpec.describe "Comments", type: :request do
  
  describe "Post /comments/id" do
    let(:current_user){ create(:user,email:"dev@gmail.com",password:"dev",password_confirmation:"dev")}
    let(:dummy_post){ build(:post)}
    let(:valid_attributes){
      {content:"This is my comment"}
    }

    it "Should redirect to login if user is not logged in" do
        post "/comment/1",params: { id:1 }
        expect(response).to redirect_to(log_in_path)
    end

    it "Should add the comment if the user is logged in" do
      login_as current_user
      dummy_post.user = current_user
      dummy_post.save
      # puts(dummy_post.id,comment_url(1)
      expect {
        post comment_url(dummy_post.id), params: valid_attributes
      }.to change(Comment, :count).by(1)
    end

    it "should be able to add for any user post" do
      login_as current_user
      user1 = create(:user,email: "test1@gmail.com")
      post_from_user1 = create(:post,user: user1)
      expect {post comment_url(post_from_user1.id), params: valid_attributes
      }.to change(Comment, :count).by(1)
    end

  end
end