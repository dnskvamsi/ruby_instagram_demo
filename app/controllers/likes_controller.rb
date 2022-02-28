class LikesController < ApplicationController
    before_action :require_user_login!

    def create
        @post = Post.find(params[:id])
        Current.user.likes.create(post: @post) unless @post.likes.find_by(user: Current.user)
        # redirect_back_or_to home_path
        # Turbo::StreamsChannel.broadcast_update_to Like,target: "post_#{@post.id}",partial:"shared/likes", locals: {post: @post}
        render turbo_stream: turbo_stream.update("post_#{@post.id}".to_sym,nil,partial:"shared/likes", locals: {post: @post})

    end

    def destroy
        @post = Post.find(params[:id])
        @post.likes.find_by(user: Current.user).destroy
        # redirect_back_or_to home_path
        render turbo_stream: turbo_stream.update("post_#{@post.id}".to_sym,nil,partial:"shared/likes", locals: {post: @post})
    end

end