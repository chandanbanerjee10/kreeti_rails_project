require 'rails_helper'

describe SectorsController do
    describe 'GET#index' do
        it "requires admin for listing sectors" do
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
            sector = create(:sector)
            session[:user_id] = sector.user.id
            get :edit, params: {id: sector}
            expect(response).to render_template('edit')
        end

        it "redirects to the login page if the admin is not logged in" do
            sector = create(:sector)
            get :edit, params: {id: sector}
            expect(response).to redirect_to login_path
        end
    end

    describe 'POST#create' do
        context "with valid attributes" do
            it 'successfully creates a new sector' do
                admin = create(:admin)
                session[:user_id] = admin.id
                expect{
                    post :create, params: {sector: attributes_for(:sector) }
                }.to change(Sector, :count).by(1)
            end   

            it 'redirects to sectors index page after sector creation' do
                admin = create(:admin)
                session[:user_id] = admin.id
                post :create, params: {sector: attributes_for(:sector) }
                expect(response).to redirect_to sectors_path 
            end   
        end

        context "with invalid attributes" do
            it 'redirects to login page and does not create sector without admin' do
                expect{
                    post :create, params: {sector: attributes_for(:sector) }
                }.to change(Sector, :count).by(0)
                expect(response).to redirect_to login_path 
            end   

            it 're-renders the new page for an invalid sector name' do
                admin = create(:admin)
                session[:user_id] = admin.id
                post :create, params: {sector: attributes_for(:invalid_sector) }
                expect(response).to render_template('new')
            end   
        end
    end

    describe 'PATCH#update' do
        before :each do
            @sector = create(:sector)
            session[:user_id] = @sector.user.id
        end

        context "with valid attributes" do
            it "updates the sector and redirects to the sectors listing page" do
                patch :update, params: {id: @sector, sector: {name: 'Manufacturing'} }
                @sector.reload
                expect(@sector.name).to eq('Manufacturing')
                expect(response).to redirect_to sectors_path   
            end
        end

        context "with invalid attributes" do
            it "re-renders the edit page for an invalid sector name" do
                patch :update, params: {id: @sector, sector: {name: '99Banking'} }
                @sector.reload
                expect(response).to render_template('edit')
            end
        end
    end

    describe 'DELETE#destroy' do
        it "deletes the user and redirects to the root path" do
            sector = create(:sector)
            session[:user_id] = sector.user.id
            expect{
                delete :destroy, params: {id: sector}
              }.to change(Sector, :count).by(-1)
            expect(response).to redirect_to sectors_path  
        end
    end
end