require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validates the Realtionship' do
    let(:relation) { build(:Relationship) }

    it "Should be valid" do
      expect(relation.save).to eq(true)
    end

    it "user1 should be following 2 persons" do
      user1 = create(:user,email:"ex1@gmail.com")
      user2 = create(:user,email:"ex2@gmail.com")
      user3 = create(:user,email: "ex3@gmail.com")
      Relationship.create(follower:user1,followed: user2)
      Relationship.create(follower:user1,followed: user3)
      expect(user1.following.length).to eq(2)
      # user3.destroy

    end

    it "1 person is following user1" do
      user1 = create(:user,email:"ex1@gmail.com")
      user2 = create(:user,email:"ex2@gmail.com")
      Relationship.create(follower: user2,followed: user1)
      expect(user1.followers.length).to eq(1)
    end

    it "should be invalid if follower is not present" do
      relation.follower = nil
      expect(relation.save).to eq(false)
    end

    it "should be invalid if followed person doesn't exist" do
      relation.followed = nil
      expect(relation.save).to eq(false)
    end

  end

end
