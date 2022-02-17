class MainController < ApplicationController
    before_action :require_user_login!

    def index
    end

    def explore
        @users=User.where.not(id: session[:user_id])
        @posts = Post.all
    end

    def profile
        @user = User.find(params[:id])
        @myposts = @user.posts.all
    end

    def search
        @users = User.where('email LIKE ?',"%#{params[:search]}%" )
        render :explore,status: :unprocessable_entity
    end

end