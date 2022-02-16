class MainController < ApplicationController
    def index
        flash[:notice] = "LogIN successful"
        flash[:alert] = "Invalid"
    end
end