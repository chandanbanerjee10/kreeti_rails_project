class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_user, only: [:show]
    before_action :require_same_user, only: [:edit, :update, :destroy, :my_posts, :my_jobs]
    before_action :require_candidate, only: [:my_posts]
    before_action :require_recruiter, only: [:my_jobs]
    before_action :require_admin, only: [:index]

    def new
        @user = User.new
    end

    def show

    end
    
    def edit
    end

    def create
        @user = User.new(user_params)
        if @user.save && @user.role == "candidate"
            session[:user_id] = @user.id
            flash[:notice] = "candidate was created successfully."
            redirect_to @user
        elsif @user.save && @user.role == "recruiter"
            session[:user_id] = @user.id
            flash[:notice] = "recruiter was created successfully."
            redirect_to @user

        elsif @user.save && @user.role == "admin"
            session[:user_id] = @user.id
            flash[:notice] = "admin was created successfully."
            redirect_to admin_path
            
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your account information was successfully updated!"
            redirect_to @user
        else
            flash.now[:notice] = "There was an error updating your account information."
            render 'edit', status: :unprocessable_entity
        end
    end

    def index
        @users = User.page params[:page]
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:danger] = "Account successfully deleted"
        redirect_to root_path, status: :see_other
    end

    def respond_to_candidate
        @post = Post.find(params[:id])
        @post.is_approved = true    
        @post.save!
        RespondMailer.respond_to_candidate(@post).deliver_later
        redirect_to job_posts_path(@post), status: :see_other
    end

    def my_posts
        @user = User.find(params[:id])
        @my_posts = @user.posts.page params[:page]
    end

    def my_jobs
        @user = User.find(params[:id])
        @my_jobs = @user.jobs.page params[:page]
    end

    private
        def user_params
            params.require(:user).permit(:username,:email,:password,:role)
        end

        def set_user
            @user = User.find(params[:id])
        end

        def require_same_user
            @user = User.find(params[:id])
            if current_user != @user
              flash[:danger] = "You can only edit or delete your own account"
              session[:user_id] = nil
              redirect_to login_path
            end
        end

end