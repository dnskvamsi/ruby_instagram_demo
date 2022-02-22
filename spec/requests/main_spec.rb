require 'rails_helper'

RSpec.describe "Main", type: :request do
    let(:current_user) {create(:user,email:"dev@gmail.com")}

    describe "GET /home" do

        it "Should redirect to login_path without logging in" do
            get home_path
            expect(response).to redirect_to(log_in_path)
        end

        it "Should render index.html" do
            login_as current_user
            get home_path
            expect(response).to render_template(:index)
        end

    end

    describe "GET /explore" do

        it "Should redirect to login_path without logging in" do
            get explore_path
            expect(response).to redirect_to(log_in_path)
        end

        it "Should render explore.html.erb if logged in" do
            login_as current_user
            get explore_path
            expect(response).to render_template(:explore)
        end

    end

    describe "GET /profile" do

        it "Should redirect to login_path without logging in" do
            get profile_path(1)
            expect(response).to redirect_to(log_in_path)
        end

        it "Should render profile.html.erb if logged in" do
            login_as current_user
            get profile_url(current_user.id)
            expect(response).to render_template(:profile)
        end

        it "Should be able to see other profile also" do
            login_as current_user
            user1 = create(:user,email:"test@gmail.com")
            get profile_url(user1.id)
            expect(response).to be_successful
        end

    end

    describe "Post /search" do

        it "Should redirect to login_path without logging in" do
            post search_url,params: {}
            expect(response).to redirect_to(log_in_path)
        end

        it "Should render explore template" do
            login_as current_user
            post search_url,params: {search: "va" }
            expect(response).to render_template(:explore)
        end

    end

end