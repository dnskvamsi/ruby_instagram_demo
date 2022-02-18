class RelationshipsController < ApplicationController

    def create
        other_user=User.find(params[:id])
        @rel = Relationship.new(follower_id:Current.user.id,
                                followed_id:other_user.id)
        @rel.save
        redirect_back_or_to home_path,notice: "You were following #{other_user.email}"
    end

    def destroy
        @rel = Relationship.find(params[:id])
        @rel.destroy
        redirect_back_or_to home_path
    end

end
