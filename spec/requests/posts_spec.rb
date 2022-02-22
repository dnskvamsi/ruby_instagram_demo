require 'rails_helper'

RSpec.describe "posts", type: :request do
    let(:current_user){ build(:user,email:"dev@gmail.com",password:"dev",password_confirmation:"dev")}
    let(:login){
        current_user.save
        post log_in_url,params: {email:"dev@gmail.com",password:"dev"}
    }

    let(:posted){ build(:post) }
    let(:valid_attributes){
        posted.image.attach(io: File.open('spec/test_image/2.jpeg'), filename: '2.jpeg', content_type: 'image/jpeg')
        {image: posted.image,description: posted.description,title: posted.title,location: posted.location}
    }

    describe "GET /post" do

        it "without logging in it should redirect to login_path" do
          get post_path
          expect(response).to redirect_to(log_in_path)
        end

        it "should render the new.html from posts view" do
            login
            get post_path
            expect(response).to render_template(:new)
        end
    end

    describe "post /post with valid params" do

        it "should be render the new for valid" do
            login
            # puts("From testing",valid_attributes[:image])
            post post_path,params: {post: {image:fixture_file_upload('spec/test_image/1.jpeg', 'image/jpeg')}}
            expect(response).to redirect_to(profile_path(current_user.id))
        end

        it "should be render the new for invalid" do
            login
            post post_url,params: {post: {image: nil,description: nil,location: nil,title: nil}}
            expect(response).to render_template(:new)
        end
    end

    describe "GET show_post/:id" do

        it "should redirect to login_path with out logged in" do
            posted.user = current_user
            posted.save
            get "/show_post/#{posted.id}"
            expect(response).to redirect_to(log_in_path)
        end

        it "should returns http success post login" do
            login
            posted.user = current_user
            posted.save
            get "/show_post/#{posted.id}"
            expect(response).to be_successful
            expect(response).to render_template(:show)
        end 

        it "Should show other user post also" do
            login
            user1=create(:user,email:"new@gmail.com")
            posted.user = user1
            posted.save
            get "/show_post/#{posted.id}"
            expect(response).to be_successful
        end
    end
    describe "delete delete_post/:id" do

        it "Should redirect to log_in_path if not logged in" do
            delete "/delete_post/2"
            expect(response).to redirect_to(log_in_path)
        end

        it "Should only delete current user post" do
            login
            posted.user = current_user
            posted.save
            delete "/delete_post/#{posted.id}"
            expect(response).to redirect_to(home_path)
        end

        it "Should redirect to post path if it is not current user's post" do
            login
            user1 = create(:user,email:"test@gmail.com")
            posted.user = user1
            posted.save
            delete "/delete_post/#{posted.id}"
            expect(response).to redirect_to(show_path(posted.id))
        end
        
    end
end