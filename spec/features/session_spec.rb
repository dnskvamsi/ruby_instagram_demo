require 'rails_helper'

RSpec.feature "Session", type: :feature do
    let(:current_user) {create(:user,email: "dev@gmail.com")}

    describe "With in-valid credntials" do

        it "should have a alert" do
            visit(log_in_path)
            fill_in 'Email', with: current_user.email
            fill_in 'Password', with: ""
            click_button "log-in"
            expect(page).to have_content("Invalid Mail or Password")
        end

    end

    describe "With valid credentials" do

        before :each do
            visit log_in_path
            fill_in 'Email', with: current_user.email
            fill_in 'Password', with: current_user.password
            click_button "log-in"
        end

        after :each do
            visit log_in_path
        end

        it "should redirect to home" do
            expect(current_path).to eq(home_path)
        end

        it "should have notice" do
            expect(page).to have_content("Logged in succesfully")
        end

    end

end