class PostsController < ApplicationController
    before_action :require_candidate , only: [:new, :create] 
    before_action :require_recruiter, only: [:index, :destroy, :show]
    before_action :require_same_post_id, only: [:show, :destroy]

    def new
        @post = Post.new
        @job = Job.find(params[:job_id])        
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
          flash[:danger] = "Incorrect Credentials"
          render "new", status: :unprocessable_entity
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
            flash[:success] = "Job post successfully deleted"
            redirect_to job_path(@post.job), status: :see_other
        else
            flash[:danger] = "There was a problem regarding deletion of this post"
            redirect_to job_path(@post.job), status: :see_other
        end
    end

    def respond_to_candidate
        @post = Post.find(params[:id])   
        if @post.save
            @post.is_approved = true
            @post.save! 
            flash[:notice] = "Mail has been sent to the candidate"
            RespondMailer.respond_to_candidate(@post).deliver_later
            redirect_to post_path(@post)
        else
            flash[:notice] = "Due to some errors mail cannot be sent"
            redirect_to post_path(@post)
        end
    end

    def reject_candidate
        @post = Post.find(params[:id])
        RespondMailer.reject_candidate(@post).deliver_now
        if @post.destroy
            flash[:notice] = "The post has been deleted"
            redirect_to job_path(@post.job), status: :see_other
        else
            flash[:notice] = "There was some error regarding deletion of this post"
            redirect_to job_path(@post.job), status: :see_other
        end
    end

    private
    def post_params
        params.require(:post).permit(:name, :post_description, :username, :phone_number, :city, :file,:job_id)
    end

    def require_same_post_id
        if current_user.is_recruiter?
            @post = Post.find(params[:id])
            job_ids = current_user.jobs.ids
            if !job_ids.include? @post.job.id
                flash[:danger] = "You can't see or modify other applicants' post other than your posted job"
                redirect_to jobs_path
            end
        end
    end


end