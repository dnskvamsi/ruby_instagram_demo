class PostsController < ApplicationController
    before_action :require_user_login!

    def new
        @post = Post.new
    end

    def create
        # puts(session[:user_id])
        # puts params
        user = Current.user
        # puts("from current",post_params)
        @post = user.posts.new(post_params)
        if @post.save
            redirect_to profile_path(user.id), notice: "Posted"
        else
            render :new,status: :unprocessable_entity
        end
    end

    def show
       @post = Post.find(params[:id])
    #    puts(@post.user)
       @following_person_uid = []
       Current.user.following.each do |following_person|
           @following_person_uid.append(following_person.followed_id)
       end
    end

    def destroy
        if(Post.find(params[:id]).user == Current.user)
            Post.find(params[:id]).destroy
            redirect_to home_path
        else
            redirect_to show_path(params[:id])
        end
    end
    private 

    def post_params
        params.require(:post).permit(:image,:title,:location,:description)
    end

end