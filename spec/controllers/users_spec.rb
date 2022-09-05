require 'rails_helper'

describe UsersController do
    describe 'GET#new' do
      it "requires signup" do
        get :new
        expect(response).to render_template("new")
      end
    end

    describe 'GET#index' do
      it "requires admin for listing users" do
        admin_user = create(:admin)
        session[:user_id] = admin_user.id
        get :index
        expect(response).to render_template("index")
      end

      it "requires admin login" do
        get :index
        expect(response).to redirect_to login_path
      end
    end

    describe 'GET#show' do
      it "requires user to be logged in for show page" do
        user = create(:candidate)
        session[:user_id] = user.id
        get :show, params: {id: user}
        expect(response).to render_template('show')
      end

      it "requires login" do
        user = create(:candidate)
        get :show, params: {id: user}
        expect(response).to redirect_to login_path
      end
    end

    describe 'POST#create' do
      it 'successfully creates a new user' do
        expect{
            post :create, params: { :user => { username: "testuser", password: "asdfasdf", email: "abc@gmail.com" } }
          }.to change(User,:count).by(1)
      end

      
    end
end