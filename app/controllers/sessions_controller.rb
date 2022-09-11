class SessionsController < ApplicationController
    before_action :logged_in_redirect, only: [:new, :create]
    def new
        
    end

    def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            flash[:notice] = "logged in successfully"
            if @user.is_admin?
                redirect_to admin_path
            else
                redirect_to @user
            end
        else
            flash[:danger] = "There is something wrong with your login information"
            render 'new', status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged out Successfully"
        redirect_to root_path, status: :see_other
    end

    def omniauth
        user = User.find_or_create_by(uid: request.env['omniauth.auth'][:uid], provider: request.env['omniauth.auth'][:provider]) do |u|
            u.username = request.env['omniauth.auth'][:info][:name]
            u.email = request.env['omniauth.auth'][:info][:email]
            u.password = SecureRandom.hex(15)
        end
        if user.valid?
            session[:user_id] = user.id
            flash[:notice] = "You have logged in successfully"
            redirect_to user_path(user)
        else
            flash[:notice] = "There is something wrong with your login info"
            redirect_to login_path
        end
    end

    private

    def logged_in_redirect
        if logged_in?
            flash[:error] = "You are already logged in"
            redirect_to root_path
        end
    end 
end
