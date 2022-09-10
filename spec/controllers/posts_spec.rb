require 'rails_helper'

describe PostsController do
    describe 'GET#new' do
        before :each do
            @job = create(:job)
        end
        it "renders the new page for a candidate" do
            candidate = create(:candidate)
            session[:user_id] = candidate.id
            get :new, params: {job_id: @job}
            expect(response).to render_template("new")
        end

        it "redirects to login page for a recruiter" do
            recruiter = create(:recruiter)
            session[:user_id] = recruiter.id
            get :new
            expect(response).to redirect_to login_path
        end
    end

    describe "POST#create" do
        before :each do
            @job = create(:job)
        end

        context "with valid attributes" do
            it "creates a new post and redirects to the job show page" do
                @candidate = create(:candidate)
                session[:user_id] = @candidate.id
                expect{
                    post :create, params: {post: attributes_for(:post, user_id: @candidate), job_id: @job.id}
                }.to change(Post, :count).by(1)
                expect(response).to redirect_to @job
            end   
        end  

        context "with invalid attributes" do
            it "redirects to login page if a non-candidate tries to create" do
                @recruiter = create(:recruiter)
                session[:user_id] = @recruiter.id
                expect{
                    post :create, params: {post: attributes_for(:post, user_id: @candidate), job_id: @job.id}
                }.to change(Job, :count).by(0)
                expect(response).to redirect_to login_path 
            end   
        end  
    end

    describe "GET#show" do
        before :each do
            @post = create(:post)
            @job = @post.job
        end

        context "with valid attributes" do
            it "renders the post show page to the recruiter who has created the job" do
                session[:user_id] = @job.user.id
                get :show, params: {id: @post}
                expect(response).to render_template('show')
            end   
        end  

        context "with invalid attributes" do
            it "redirects to the jobs listing path to other recruiters" do
                @recruiter = create(:recruiter)
                session[:user_id] = @recruiter.id
                get :show, params: {id: @post}
                expect(response).to redirect_to jobs_path
                expect(flash[:danger]).to eq("You can't see or modify other applicants' post other than your posted job") 
            end 

            it "redirects to the login page to non-recruiters" do
                @candidate = create(:candidate)
                session[:user_id] = @candidate.id
                get :show, params: {id: @post}
                expect(response).to redirect_to login_path
            end   
        end  
    end

    describe "DELETE#destroy" do
        context "with the recruiter who created this job" do
            it "deletes the job and redirects to the jobs list page" do
                @post = create(:post)
                @job = @post.job
                session[:user_id] = @job.user.id
                expect{
                    delete :destroy, params: {id: @post}
                }.to change(Post, :count).by(-1)
                expect(response).to redirect_to @job
                expect(flash[:success]).to eq("Job post successfully deleted") 
            end
        end

        context "with invalid users" do
            it "redirects to the job page for other recruiters" do
                @post = create(:post)
                @job = @post.job
                @recruiter = create(:recruiter)
                session[:user_id] = @recruiter.id
                expect{
                    delete :destroy, params: {id: @post}
                }.to change(Post, :count).by(0)
                expect(response).to redirect_to jobs_path
                expect(flash[:danger]).to eq("You can't see or modify other applicants' post other than your posted job") 
            end

            it "redirects to the login page for candidates who applied their posts" do
                @post = create(:post)
                @candidate = @post.user
                session[:user_id] = @candidate.id
                expect{
                    delete :destroy, params: {id: @post}
                }.to change(Post, :count).by(0)
                expect(response).to redirect_to login_path
            end
        end
    end
    
end