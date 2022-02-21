require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validates the Post' do
    let(:post) { build(:post) }
    let(:user) {build(:user)}

    it "should not check for title" do
      post.title = nil
      expect(post.save).to eq(true)
    end

    it "should not check for description" do
      post.description = nil
      expect(post.save).to eq(true)
    end

    it "should not check for location" do
      post.location = nil
      expect(post.save).to eq(true)
    end

    it "should check for valid image type" do
      post.image.attach(io: File.open('spec/test_image/2.jpeg'), filename: '2.jpeg', content_type: 'image/jpeg')
      expect(post.save).to eq(true)
    end

    it "should reject other file types" do
      post.image.attach(io: File.open('spec/test_image/a.txt'), filename: 'a.txt')
      expect(post.save).to eq(false)
    end

    it "should delete the post if user is deleted" do
      post.save
      user.posts << post
      expect { user.destroy }.to change { Post.count }.by(-1)
    end
    
  end

end
