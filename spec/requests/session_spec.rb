require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:current_user){ build(:user,email:"dev@gmail.com",password:"dev",password_confirmation:"dev")}

  let(:valid_attributes) {
    {email:"dev@gmail.com",password:"dev"}
    }

    let(:invalid_attributes) {
      {email:"dev@gmail.com",password:"dev1"}
    }

    describe "GET /log_in" do

      it "returns http success" do
        get log_in_path
        expect(response).to be_successful
        expect(response).to have_http_status(:success)
      end

      it "should render a new.html.erb" do
        get log_in_path
        expect(response).to render_template(:new)
      end

    end

    describe "POST /log_in" do

      it "for a valid login credentials it should redirect to home" do
        current_user.save
        post log_in_url,params: valid_attributes
        expect(response).to redirect_to(home_path)
      end

      it "should render new for invalid credentials" do
        post log_in_url,params: invalid_attributes
        expect(response).to render_template(:new)
      end

    end

    describe "Delete /logout" do

      it "should delete the session[:user_id]" do
        current_user.save
        post log_in_url,params: valid_attributes
        # puts(session[:user_id])
        delete logout_path
        expect(session[:user_id]).to eq(nil)
      end

    end

end