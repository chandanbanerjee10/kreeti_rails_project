class PostsController < ApplicationController
    before_action :require_candidate , only: [:new, :create] 
    before_action :require_admin_recruiter, only:[:index, :destroy]
    before_action :require_same_recruiter, only:[:index]
    before_action :require_same_post_id, only:[:show]
    def new
        @post = Post.new
    end

    def create
        @post = Post.create(post_params)   
        @job = Job.find(params[:job_id])
        @post.job = @job
        @post.user = current_user 
        if @post.save
          flash[:success] = "Job Post successfully created"
          redirect_to @job
        else
          flash[:error] = "Something went wrong"
          render 'new' , status: :unprocessable_entity
        end
    end
    
    def show
        @post = Post.find(params[:id])
    end

    def index
        @posts = Post.all    
        @job = Job.find(params[:job_id])
    end

    def destroy
        @post = Post.find(params[:id])
        if @post.destroy
            flash[:danger] = "Job post successfully deleted"
            redirect_to job_path(@post.job), status: :see_other
        end
    end

    private
    def post_params
        params.require(:post).permit(:name, :post_description, :username, :phone_number, :city, :file,:job_id)
    end

    def require_same_recruiter
        @job = Job.find(params[:job_id])
        if current_user != @job.user
            flash[:danger] = "You can't see other recruiters' post requests"
            redirect_to jobs_path
        end
    end

    def require_same_post_id
        if current_user.is_recruiter?
            @post = Post.find(params[:id])
            job_ids = current_user.jobs.ids
            if !job_ids.include? @post.job.id
                flash[:danger] = "You can't see other applicants' post other than your posted job"
                redirect_to jobs_path
            end
        end
    end


end