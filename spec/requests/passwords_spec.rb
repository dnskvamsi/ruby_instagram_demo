require 'rails_helper'

RSpec.describe "Passwords", type: :request do
    let(:current_user) { create(:user,email:"dev@gmail.com") }

    describe "GET edit_password_path" do

        it "Should redirect to login if not logged in" do
            get edit_password_path
            expect(response).to redirect_to(log_in_path)
        end

        it "Should return success if logged in" do
            login_as current_user
            get edit_password_path
            expect(response).to be_successful
        end

        it "should render edit html" do
            login_as current_user
            get edit_password_path
            expect(response).to render_template(:edit)
        end

    end

    describe "patch password_path" do
        
        let(:valid_attributes){
            {user:{password: "password",password_confirmation: "password"}}
        }
        let(:invalid_attributes){
            {user:{password: "password",password_confirmation: "password1"}}
        }

        it "Should redirect to login if not logged in" do
            patch passwords_url
            expect(response).to redirect_to(log_in_path)
        end

        it "Should render edit page with invalid inputs" do
            login_as current_user
            patch passwords_url,params: invalid_attributes
            expect(response).to render_template(:edit)
        end

        it "Should redirect to home with valid inputs" do
            login_as current_user
            patch passwords_url,params: valid_attributes
            expect(response).to redirect_to(home_path)
        end

    end

end