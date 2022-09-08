require 'rails_helper'

describe ChatroomController do
    describe "GET#index" do
        it "renders the index page for a candidate" do
            user = create(:candidate)
            session[:user_id] = user.id
            get :index
            expect(response).to render_template("index") 
        end 
    end
end