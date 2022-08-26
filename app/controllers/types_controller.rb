class  TypesController < ApplicationController
    before_action :require_user 
    before_action :require_admin_recruiter, only: [:new, :create]
    before_action :require_admin, except: [:new, :create]

    def new
        @type = Type.new
    end

    def create
        @type= Type.new(type_params)
        @type.user = current_user
        if current_user.is_admin?
            if @type.save
            flash[:success] = "Type successfully created"
            redirect_to types_path
            else
            render 'new' , status: :unprocessable_entity
            end
        else
            if @type.save
                flash[:success] = "Type successfully created"
                redirect_to new_type_path
            else
                render 'new' , status: :unprocessable_entity
            end
        end
    end
    
    def show
        @type = Type.find(params[:id])
    end

    def index
        @types = Type.page params[:page]
    end

    def destroy
        @type = Type.find(params[:id])
        if @type.destroy
            flash[:danger] = "Type successfully deleted"
            redirect_to types_path, status: :see_other
        else
            flash[:notice] = "There was a problem regarding deletion of this job"
            redirect_to types_path, status: :see_other
        end
    end

    def edit
        @type = Type.find(params[:id])
    end

    def update
        @type = Type.find(params[:id])
        @type.user = current_user
        if @type.update(type_params)
            flash[:success] = "Type successfully updated"
            redirect_to types_path
        else
            render 'edit' , status: :unprocessable_entity
        end
    end
    private
    def type_params
        params.require(:type).permit(:name)
    end
end