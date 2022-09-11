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

    it "redirects to the login page as user is not signed in" do
      user = create(:candidate)
      get :show, params: {id: user}
      expect(response).to redirect_to login_path
    end
  end

  describe 'GET#edit' do
    it "requires user to be logged in for edit page" do
      user = create(:candidate)
      session[:user_id] = user.id
      get :edit, params: {id: user}
      expect(response).to render_template('edit')
    end

    it "redirects to the login page as user is not signed in" do
      user = create(:candidate)
      get :edit, params: {id: user}
      expect(response).to redirect_to login_path
    end
  end

  describe 'POST#create' do 
    context "with valid user attributes" do
      it 'successfully creates a new user' do
        expect{
            post :create, params: {user: attributes_for(:valid_user) }
          }.to change(User,:count).by(1)
      end   
      
      it "redirects to users#show" do
        post :create, params: {user: attributes_for(:valid_user)}
        expect(response).to redirect_to user_path(User.last)
      end
    end  

    context "with invalid user attributes" do
      it "does not save the new user in the database" do
        expect{
          post :create, params: {user: attributes_for(:invalid_user)}
        }.to_not change(User, :count)
      end

      it "renders the :new template for an invalid user" do
        post :create, params: {user: attributes_for(:invalid_user)}
        expect(response).to render_template('new')  
        expect(response.status).to eq(422)  
      end
    end
  end

  describe "PATCH#Update" do
    before :each do
      @user = create(:valid_user)
    end

    context "with valid user attributes" do
      it "updates the user and redirects to user show path" do
        session[:user_id] = @user.id
        patch :update, params: {id: @user, user: {username: 'chandan'} }
        @user.reload
        expect(@user.username).to eq('chandan')
        expect(response).to redirect_to user_path(@user)
      end
    end

    context "with invalid user attributes" do
      it "does not update the user with an invalid attribute" do
        session[:user_id] = @user.id
        patch :update, params: {id: @user, user: {username: "" } }
        @user.reload
        expect(response).to render_template('edit')
      end

      it "redirects to the login page if not logged in" do 
        patch :update, params: {id: @user, user: {username: "chandan" } }
        @user.reload
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE#destroy' do
    it "deletes the user and redirects to the root path" do
      user = create(:candidate)
      session[:user_id] = user.id
      expect{
        delete :destroy, params: {id: user}
      }.to change(User, :count).by(-1)
      expect(response).to redirect_to root_path 
      expect(flash[:danger]).to eq("Account successfully deleted") 
    end
  end

  describe 'GET#my_posts' do
    it "renders all the posts of the candidate" do
      candidate = create(:candidate)
      session[:user_id] = candidate.id
      get :my_posts, params: {id: candidate}
      expect(response).to render_template('my_posts')
    end
  end

  describe 'GET#my_jobs' do
    it "renders all the approved jobs posted by the recruiter" do
      recruiter = create(:recruiter)
      session[:user_id] = recruiter.id
      get :my_jobs, params: {id: recruiter}
      expect(response).to render_template('my_jobs')
    end
  end
end