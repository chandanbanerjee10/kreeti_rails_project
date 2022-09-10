require 'rails_helper'

describe JobsController do
    describe 'GET#new' do
        it "renders the new page for a recruiter" do
            recruiter_user = create(:recruiter)
            session[:user_id] = recruiter_user.id
            get :new
            expect(response).to render_template("new")
        end

        it "redirects to login page for a candidate" do
            candidate = create(:candidate)
            session[:user_id] = candidate.id
            get :new
            expect(response).to redirect_to login_path
        end
    end

    describe 'GET#index' do
        it "renders to jobs index page without login" do
            get :index
            expect(response).to render_template("index")
        end
    end

    describe "GET#show" do
        before :each do
            @job = create(:job)
        end

        it "requires login for viewing job show" do
            session[:user_id] = @job.user.id
            get :show, params: {id: @job}
            expect(response).to render_template("show")
        end

        it "redirects to the login page for users not signed in" do
            get :show, params: {id: @job}
            expect(response).to redirect_to login_path
        end
    end

    describe "GET#edit" do
        before :each do
            @job = create(:job)
        end

        it "renders the new page for the recruiter who created the job" do
            session[:user_id] = @job.user.id
            get :edit, params: {id: @job}
            expect(response).to render_template("edit")
        end

        it "redirects to the jobs listing page for other recruiters" do
            recruiter = create(:recruiter)
            session[:user_id] = recruiter.id
            get :edit, params: {id: @job}
            expect(response).to redirect_to jobs_path
            expect(flash[:danger]).to eq("You can only edit or delete your own jobs")
        end

        it "redirects to login page for non-recruiters" do
            candidate = create(:candidate)
            session[:user_id] = candidate.id
            get :edit, params: {id: @job}
            expect(response).to redirect_to login_path
        end
    end

    describe "POST#create" do
        before :each do
            @sector = create(:sector)
            @type = create(:type)
        end

        context "with valid job attributes" do
            it "creates a new job and redirects to the jobs listing page" do
                @recruiter = create(:recruiter)
                session[:user_id] = @recruiter.id
                expect{
                    post :create, params: {job: attributes_for(:job, sector_id: @sector, type_id: @type)}
                }.to change(Job, :count).by(1)
                expect(response).to redirect_to jobs_path 
            end   
        end  

        context "with invalid job attributes" do
            it "redirects to login page if a non-recruiter tries to create" do
                @candidate = create(:candidate)
                session[:user_id] = @candidate.id
                expect{
                    post :create, params: {job: attributes_for(:job, sector_id: @sector, type_id: @type)}
                }.to change(Job, :count).by(0)
                expect(response).to redirect_to login_path 
            end   
        end  
    end

    describe "POST#update" do
        before :each do
            @job = create(:job)
        end
        
        context "with valid attributes" do
            it "updates the job and redirects to jobs list path" do
                session[:user_id] = @job.user.id
                patch :update, params: {id: @job, job: {title: 'new job'} }
                @job.reload
                expect(@job.title).to eq('new job')
                expect(response).to redirect_to jobs_path
            end
        end

        context "with invalid attributes" do
            it "does not update the job for blank title" do
                session[:user_id] = @job.user.id
                patch :update, params: {id: @job, job: {title: ''} }
                @job.reload
                expect(response).to render_template('edit')
            end

            it "redirects to the jobs listing page for other recruiters" do
                recruiter = create(:recruiter)
                session[:user_id] = recruiter.id
                patch :update, params: {id: @job, job: {title: 'new job'} }
                expect(response).to redirect_to jobs_path  
                expect(flash[:danger]).to eq("You can only edit or delete your own jobs") 
            end
        end
    end

    describe 'DELETE#destroy' do
        before :each do
            @job = create(:job)
        end
        
        it "deletes the job and redirects to the jobs list page" do
          session[:user_id] = @job.user.id
          expect{
            delete :destroy, params: {id: @job}
          }.to change(Job, :count).by(-1)
          expect(response).to redirect_to jobs_path 
          expect(flash[:success]).to eq("Job is successfully deleted.") 
        end
    end
end