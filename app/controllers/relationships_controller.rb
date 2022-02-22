class RelationshipsController < ApplicationController
    before_action :require_user_login!

    def create
        other_user=User.find(params[:id])
        if(other_user != Current.user)
            @rel = Relationship.new(follower_id:Current.user.id,
                                    followed_id:other_user.id)
            @rel.save
            redirect_back_or_to home_path,notice: "You were following #{other_user.email}"
        else
            redirect_to home_path
        end
    end

    def destroy
        @rel = Relationship.find(params[:id])
        @rel.destroy
        redirect_back_or_to home_path
    end

end
