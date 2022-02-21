require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validates the comment' do
    let(:user) {create(:user,email: "email@gmail.com")}
    let(:comment) { build(:comment) }
    let(:post) {build(:post)}
    
    

    it "check the content of comment" do
      expect(comment.content).to eq("My comment")
    end

    it "should accept the empty content also" do
      comment.content = nil
      expect(comment.save).to eq(true)
    end

    it "should delete all the comments when post is deleted" do
      post.save
      comment.save
      user.posts << post
      post.comments << comment
      expect { post.destroy }.to change { Comment.count }.by(-1)
    end

    it "should delete all the comments when post is deleted" do
      post.save
      comment.save
      user.posts << post
      post.comments << comment
      expect {user.destroy}.to change {Comment.count}.by(-1)

    end

  end

end
