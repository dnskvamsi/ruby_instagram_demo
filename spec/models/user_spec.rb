require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates the User' do
    let(:user) { build(:user) }

    it "check email is present" do
      user.email = nil
      expect(user.save).to eq(false)
    end

    it "Should validate the email pattern" do
      user.email="name"
      expect(user.save).to eq(false)
    end

    it "should validate to email with valid inputs" do
      user.email = "name@name.com"
      expect(user.save).to eq(true)
    end

    it "check password is present" do
      user.password = nil
      expect(user.save).to eq(false)
    end

    it "check confirm password is present" do
      user.password_confirmation = nil
      expect(user.save).to eq(false)
    end

    it "check password and confirpassword are same" do
      expect(user.password).to eq(user.password_confirmation)
    end

    it "return false if password and password_confirmation is not same" do
      user.password = "name"
      user.password_confirmation ="name1"
      expect(user.save).to eq(false)
    end

    it "return a custom message if email format is wrong" do
      user.email ="name"
      user.save
      expect(user.errors.full_messages).to include("Email Must be a valid email address")
    end

    it "has a unique email with exact match" do
      user1 = create(:user,email: "name@gmail.com")
      user2 = build(:user,email: "name@gmail.com")
      expect(user2.save).to eq(false)
      user2.save
      expect(user2.errors.full_messages).to include("Email  already exists")
    end

    it "has a unique email ignoring case sensitivity" do
      user1 = create(:user,email: "name@gmail.com")
      user2 = build(:user,email: "Name@gmail.com")
      expect(user2.save).to eq(false)
      user2.save
      expect(user2.errors.full_messages).to include("Email  already exists")
    end

  end
end

