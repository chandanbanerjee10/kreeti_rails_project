class ApplicationController < ActionController::Base
    include ApplicationHelper

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        end
    end

    def require_admin
        # binding.pry
        if !logged_in? 
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        elsif current_user.is_admin?
            session[:user_id] = nil
            flash[:alert] = "You must be an admin to perform that action"
            redirect_to login_path
        end
    end

    def require_recruiter
        if !logged_in? 
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        elsif current_user.role != "recruiter"
            session[:user_id] = nil
            flash[:alert] = "You must be a recruiter to perform that action"
            redirect_to login_path
        end
    end

    def require_candidate
        if !logged_in? 
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        elsif current_user.role != "candidate"
            session[:user_id] = nil
            flash[:alert] = "You must be a candidate to perform that action"
            redirect_to login_path
        end
    end

    def require_admin_recruiter
        if current_user.role == "candidate"
            flash[:alert] = "You must be a recruiter or an admin to perform that action"
            redirect_to login_path
        end
    end
 

end
