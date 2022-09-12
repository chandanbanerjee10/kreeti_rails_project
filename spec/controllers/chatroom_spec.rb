require 'rails_helper'

describe ChatroomController do
    describe "GET#index" do
        it "renders the index page for a candidate" do
            user = create(:candidate)
            session[:user_id] = user.id
            get :index
            expect(response).to render_template("index") 
        end 

        it "rendirects to the login page for non-candidates" do
            user = create(:recruiter)
            session[:user_id] = user.id
            get :index
            expect(response).to redirect_to login_path
        end 
    end
end