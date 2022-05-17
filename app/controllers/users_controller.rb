class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    # before_action :require_user, only: [:edit, :update]
    # before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
        @user = User.new
    end

    def show
        
    end
    
    def edit
    end

    def create
        # debugger
        @user = User.new(user_params)
        if @user.save && @user.role == "candidate"
            flash[:notice] = "candidate was created successfully."
            redirect_to @user
        elsif @user.save && @user.role == "recruiter"
            flash[:notice] = "recruiter was created successfully."
            redirect_to root_path

        elsif @user.save && @user.role == "admin"
            flash[:notice] = "admin was created successfully."
            redirect_to about_path
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
        @users = User.all
    end

    def destroy
        @user.destroy
        flash[:danger] = "Account successfully deleted"
        redirect_to users_path, status: :see_other
    end

    private
        def user_params
            params.require(:user).permit(:username,:email,:password,:role)
        end

        def set_user
            @user = User.find(params[:id])
        end

        def require_same_user
            if current_user != @user
              flash[:danger] = "You can only edit or delete your own account"
              redirect_to @user
            end
        end
end