require 'rails_helper'

describe UsersController do
    before :each do
      @admin_user = create(:admin)
      session[:user_id] = @admin_user.id
    end

    describe 'GET#new' do
      it "requires signup" do
        get :new
        expect(response).to render_template("new")
      end
    end

    describe 'GET#index' do
      it "requires admin" do
        get :index
        expect(response).to render_template("index")
      end
    end
end