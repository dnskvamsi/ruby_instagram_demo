class CommentsController < ApplicationController
    before_action :require_user_login!

    def create
    #    post = Post.find(params[:id])
       Comment.create(content:params[:content],post_id:params[:id],user_id:Current.user.id)
       redirect_back_or_to({action: "show",id: params[:id]})
    end

end