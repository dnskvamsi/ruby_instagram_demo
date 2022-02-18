class PostsController < ApplicationController
    before_action :require_user_login!

    def new
        @post = Post.new
    end

    def create
        # puts(session[:user_id])
        # puts params
        user = Current.user
        @post = user.posts.new(post_params)
        if @post.save
            redirect_to profile_path(user.id), notice: "Posted"
        else
            render :new,status: :unprocessable_entity
        end
    end

    def show
       @post = Post.find(params[:id])
       @following_person_uid = []
       Current.user.following.each do |following_person|
           @following_person_uid.append(following_person.followed_id)
       end
    end

    def destroy
        Post.find(params[:id]).destroy
        redirect_to home_path
    end
    private 

    def post_params
        params.require(:post).permit(:image,:title,:location,:description)
    end

end