require 'rails_helper'

describe TypesController do
    describe 'GET#index' do
        it "requires admin for listing types" do
            admin_user = create(:admin)
            session[:user_id] = admin_user.id
            get :index
            expect(response).to render_template("index")
        end
    end
    
    describe 'GET#new' do
        it "requires an admin" do
            admin_user = create(:admin)
            session[:user_id] = admin_user.id
            get :new
            expect(response).to render_template("new")
        end

        it "requires a recruiter" do
            recruiter_user = create(:recruiter)
            session[:user_id] = recruiter_user.id
            get :new
            expect(response).to render_template("new")
        end
    end

    describe 'GET#edit' do
        it "requres an admin" do
            type = create(:type)
            session[:user_id] = type.user.id
            get :edit, params: {id: type}
            expect(response).to render_template('edit')
        end

        it "redirects to the login page if the admin is not logged in" do
            type = create(:type)
            get :edit, params: {id: type}
            expect(response).to redirect_to login_path
        end
    end

    describe 'POST#create' do
        context "with valid attributes" do
            it 'successfully creates a new type' do
                admin = create(:admin)
                session[:user_id] = admin.id
                expect{
                    post :create, params: {type: attributes_for(:type) }
                }.to change(Type, :count).by(1)
            end   

            it 'redirects to sectors index page after type creation' do
                admin = create(:admin)
                session[:user_id] = admin.id
                post :create, params: {type: attributes_for(:type) }
                expect(response).to redirect_to types_path 
            end   
        end

        context "with invalid attributes" do
            it 'redirects to login page and does not create type without admin' do
                expect{
                    post :create, params: {type: attributes_for(:type) }
                }.to change(Type, :count).by(0)
                expect(response).to redirect_to login_path 
            end   

            it 're-renders the new page for an invalid type name' do
                admin = create(:admin)
                session[:user_id] = admin.id
                post :create, params: {type: attributes_for(:invalid_type) }
                expect(response).to render_template('new')
            end   
        end
    end

    describe 'PATCH#update' do
        before :each do
            @type = create(:type)
            session[:user_id] = @type.user.id
        end

        context "with valid attributes" do
            it "updates the type and redirects to the sectors listing page" do
                patch :update, params: {id: @type, type: {name: 'RND'} }
                @type.reload
                expect(@type.name).to eq('RND')
                expect(response).to redirect_to types_path   
            end
        end

        context "with invalid attributes" do
            it "re-renders the edit page for an invalid type name" do
                patch :update, params: {id: @type, type: {name: '23#Clerk'} }
                @type.reload
                expect(response).to render_template('edit')
            end
        end
    end

    describe 'DELETE#destroy' do
        it "deletes the user and redirects to the root path" do
            type = create(:type)
            session[:user_id] = type.user.id
            expect{
                delete :destroy, params: {id: type}
              }.to change(Type, :count).by(-1)
            expect(response).to redirect_to types_path  
        end
    end
end