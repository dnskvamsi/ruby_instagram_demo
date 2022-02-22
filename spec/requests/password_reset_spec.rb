require 'rails_helper'

RSpec.describe "Password Reset", type: :request do
    let(:current_user){ create(:user,email:"dev@gmail.com")}

    describe "GET /password/reset" do

        it "should render a new.html" do
            get password_reset_path
            expect(response).to render_template(:new)
        end

        it "should render a successful response" do
            get password_reset_path
            expect(response).to be_successful
        end

    end

    describe "post password/reset" do

        it "should redirect to login for a valid user mail" do
            post password_reset_url,params: { email: current_user.email }
            expect(response).to redirect_to(log_in_path)
        end

        it "should redirect to sign_up for a invalid user" do
            post password_reset_url,params: { email: "testing@gmail.com" }
            expect(response).to redirect_to(sign_up_path)
        end

    end

    describe "" do
        
    end

end