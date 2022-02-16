class MainController < ApplicationController
    before_action :require_user_login!
    def index
    end
end