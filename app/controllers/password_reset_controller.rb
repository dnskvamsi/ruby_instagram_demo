class PasswordResetController < ApplicationController

    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user.present?
            PasswordMailer.with(user: @user).reset.deliver_now
            redirect_to log_in_path,notice: "Check the email for reset password"
        else
            redirect_to sign_up_path,notice: "User doesn't exists please sign-up"
        end
    end

    def edit
        @user = User.find_signed!(params[:token],purpose: "password_reset")
    end

    def update
        @user = User.find_signed!(params[:token],purpose: "password_reset")
        if @user.update(password_params)
            redirect_to log_in_path,notice: "Password reset completed,Please Sign-in"
        else
            render :edit
        end
    end

    private
    def password_params
        params.require(:user).permit(:password,:password_confirmation)
    end

end