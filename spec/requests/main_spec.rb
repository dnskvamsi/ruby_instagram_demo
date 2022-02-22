require 'rails_helper'

RSpec.describe "Main", type: :request do

    describe "GET /home" do

        it "Should redirect to login_path without logging in" do
            get home_path
            expect(response).to redirect_to(log_in_path)
        end

    end

end