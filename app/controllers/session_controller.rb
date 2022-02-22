class SessionController < ApplicationController
    before_action :require_user_login!,only: [:destroy]

    def new
        session[:user_id]=nil
    end

    def create
        user = User.find_by(email: params[:email])
        if(user.present? && user.authenticate(params[:password]))
            session[:user_id] = user.id
            redirect_to home_path, notice: "Logged in succesfully "
        else
            flash[:alert] = "Invalid Mail or Password"
            render :new,status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end

end