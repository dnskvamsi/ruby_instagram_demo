class MainController < ApplicationController
    before_action :require_user_login!

    def index
        @all_users=User.where.not(id: Current.user.id)
        @following_person_uid = []
        Current.user.following.each do |following_person|
            @following_person_uid.append(following_person.followed_id)
        end
        @posts = Post.where(user_id: @following_person_uid).order(created_at: :desc)
    end

    def explore
        @users=User.where.not(id: session[:user_id])
        @posts = Post.all
    end

    def profile
        @user = User.find(params[:id])
        @myposts = @user.posts.all.order(created_at: :desc)
        @rel = @user.followers.find_by(follower: Current.user)
    end

    def search
        @users = User.where('email LIKE ?',"%#{params[:search]}%" ).where.not(id: Current.user.id)
        render :explore,status: :unprocessable_entity
    end

end