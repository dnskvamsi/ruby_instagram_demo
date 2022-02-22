require "rails_helper"

RSpec.feature "Main", :type => :feature do

   describe "Without login " do

    it "get home_path should return to login_path" do
        visit(home_path)
        expect(current_path).to eq(log_in_path)
    end

    it "get explore_path should return to login_path" do
        visit(explore_path)
        expect(current_path).to eq(log_in_path)
    end

    it "get profile_path should return to login_path" do
        visit(profile_path(1))
        expect(current_path).to eq(log_in_path)
    end

    it "click_search should return to login_path" do
        visit(root_path)
        click_button 'Search'
        expect(current_path).to eq(log_in_path)
    end

   end

   describe "With login" do

    let(:current_user) { create(:user, email: "dev@gmail.com") }
    before :each do
      visit log_in_path
      fill_in 'Email', with: current_user.email
      fill_in 'Password', with: current_user.password
    end

    it "should redirect to home_path" do
        click_button "log-in"
        expect(current_path).to eq(home_path)
    end

    it "should have a notice with logged in message" do
        click_button "log-in"
        expect(page).to have_content("Logged in succesfully")
    end

    it "should be able to visit profile page and have a title" do
        click_button "log-in"
        visit (profile_path(current_user.id))
        expect(page).to have_title("Profile")
        expect(page).to have_content("Following")
        expect(page).to have_content("Followers")
    end

    it "profile page should have following and followers" do
        click_button "log-in"
        visit (profile_path(current_user.id))
        expect(page).to have_content("Following")
        expect(page).to have_content("Followers")
    end

    it "should have a explore page with titile" do
        click_button "log-in"
        visit (explore_path)
        expect(page).to have_title("Explore")
    end

    it "should be able to search the user" do
        click_button "log-in"
        create(:user,email:"email@gmail.com")
        fill_in 'search',with: "em"
        click_button "Search"
        expect(page).to have_content("email@gmail.com")
    end

    it "should not show the current user" do
        click_button "log-in"
        fill_in 'search',with: "dev"
        click_button "Search"
        expect(page).to_not have_content("dev@gmail.com")
    end

   end

  end