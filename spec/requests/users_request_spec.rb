require 'rails_helper'

RSpec.describe "User", type: :request do
    # it "visits the signup page" do
    #     get "/signup"
    #     expect(response).to render_template(:new)
    # end
    before :each do
        @admin_user = create(:admin)
        session[:user_id] = @admin_user.id
    end

    it "visits the users index page" do
        get "/users"
        expect(response).to render_template(:index)
    end

    # it "visits the login page" do
    #     get "/login"
    #     expect(response).to render_template(:new)
    # end

    # it "restrict access to the chatroom page without login" do
    #     get "/chatroom"
    #     expect(response).to redirect_to login_path
    # end
end
