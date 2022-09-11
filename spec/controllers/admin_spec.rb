require 'rails_helper'

describe AdminController do
    describe "GET#home" do
        it "renders the home page of the admin profile" do
            admin = create(:admin)
            session[:user_id] = admin.id
            get :home
            expect(response).to render_template('home')  
        end 

        it "redirects to the login page for non-admins" do
            candidate = create(:candidate)
            session[:user_id] = candidate.id
            get :home
            expect(response).to redirect_to login_path
        end 
    end

    describe "GET#job_requests" do
        it "renders the unapproved jobs page waiting for admin approval" do
            admin = create(:admin)
            session[:user_id] = admin.id
            get :job_requests
            expect(response).to render_template('job_requests')  
        end 

        it "redirects to the login page for non-admins" do
            candidate = create(:candidate)
            session[:user_id] = candidate.id
            get :job_requests
            expect(response).to redirect_to login_path
        end 
    end

    describe "GET#job_show" do
        before :each do
            @job = create(:job)
        end
        it "renders the unapproved jobs page waiting for admin approval" do
            admin = create(:admin)
            session[:user_id] = admin.id
            get :job_show, params: {id: @job}
            expect(response).to render_template('job_show')  
        end 

        it "redirects to the login page for non-admins" do
            candidate = create(:candidate)
            session[:user_id] = candidate.id
            get :job_show, params: {id: @job}
            expect(response).to redirect_to login_path
        end 
    end
    
    describe "POST#job_approve" do
        before :each do
            @job = create(:job)
        end
        it "approves the pending job ready to be shown on the home page" do
            admin = create(:admin)
            session[:user_id] = admin.id
            post :job_approve, params: {id: @job}
            expect(response).to redirect_to admin_job_requests_path 
            @job.reload
            expect(@job.approved_by).to eq(admin.id)
            expect(flash[:notice]).to eq("Job was approved successfully")
        end
    end

    describe "DELETE#job_reject" do
        before :each do
            @job = create(:job)
        end
        it "deletes the pending job" do
            admin = create(:admin)
            session[:user_id] = admin.id
            delete :job_reject, params: {id: @job}
            expect(flash[:success]).to eq("Job is successfully deleted")  
            expect(response).to redirect_to admin_job_requests_path  
        end
    end
    
end