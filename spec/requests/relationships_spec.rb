require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let(:current_user) {create(:user,email:"dev@gmail.com")}

  describe "Post follow/:id" do

    it "should redirect to login_path if not logged in" do
      post follow_url(2),params: {}
      expect(response).to redirect_to(log_in_path)
    end

    it "should be able to follow the other user" do
      login_as current_user
      user1 = create(:user,email: "following@gmail.com")
      expect{post follow_url(user1.id)}.to change(Relationship,:count).by(1)
    end
    
    it "should be able to follow and redirect to home" do
      login_as current_user
      user1 = create(:user,email: "following@gmail.com")
      post follow_url(user1.id)
      expect(response).to redirect_to(home_path)
    end

    it "should not be able to follow myself" do
      login_as current_user
      # user1 = create(:user,email: "following@gmail.com")
      post follow_url(current_user.id)
      expect(response).to redirect_to(home_path)
    end

    it "should not be able to follow myself" do
      login_as current_user
      # user1 = create(:user,email: "following@gmail.com")
      post follow_url(current_user.id)
      expect(response).to redirect_to(home_path)
    end
  end

  describe "delete unfollow/:id" do
    let(:user1){create(:user,email:"user1@gmail.com")}
    let(:user2){create(:user,email:"user2@gmail.com")}
    let(:relation) {create(:Relationship,follower:user1,followed: user2) }

    it "should redirect to login_path if not logged in" do
      delete unfollow_url(2)
      expect(response).to redirect_to(log_in_path)
    end

    it "should be able to delete from the database" do
      login_as current_user
      expect {delete unfollow_url(relation.id)
      }.to change(Relationship, :count).by(0)
    end

    it "shopuld be able to redirect to home after destroy " do
      login_as current_user
      delete unfollow_url(relation.id)
      expect(response).to redirect_to(home_path)
    end

  end
end