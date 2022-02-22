require 'rails_helper'

RSpec.describe "Registrations", type: :request do
    # let(:user) { build(:user,email: "example@gmail.com") }
    let(:valid_attributes) {
    {email: "example@gmail.com",password:"testing",password_confirmation:"testing"} 
    }
    
    let(:invalid_attributes) {
        {email: "example@gmail.com",password:"testing1",password_confirmation:"testing"}
      }
    describe " GET /sign_up" do

    it "returns http success" do
      get sign_up_path
      expect(response).to be_successful
      expect(response).to have_http_status(:success)
    end

    it "should render a new.html.erb" do
       get sign_up_path
       expect(response).to render_template(:new)
    end
  end

  
  describe "post /sign_up" do

    it "for a valid user it should redirect to home_path " do
        post sign_up_url, params: {user:valid_attributes}
        expect(response).to redirect_to(home_path)
    end

    it "for a invalid user it should render a new page" do
        post sign_up_url,params: {user:invalid_attributes}
        expect(response).to render_template(:new)
    end

    it "for a valid user it should create a new user" do
        expect {
            post sign_up_url, params: { user: valid_attributes }
          }.to change(User, :count).by(1)
    end

  end

end