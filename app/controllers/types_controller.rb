class  TypesController < ApplicationController
    before_action :require_user 
    before_action :require_admin_recruiter, except: [:index, :show]

    def new
        @type = Type.new
    end

    def create
        @type= Type.new(type_params)
        @type.user = current_user
        if @type.save
          flash[:success] = "Sector successfully created"
          redirect_to types_path
        else
          flash[:error] = "Something went wrong"
          render 'new' , status: :unprocessable_entity
        end
    end
    
    def show
        # debugger
        @type = Type.find(params[:id])
    end

    def index
        @types = Type.all
    end

    def destroy
        @type = Type.find(params[:id])
        @type.destroy
        flash[:danger] = "Sector successfully deleted"
        redirect_to types_path, status: :see_other
    end

    def edit
        @type = Type.find(params[:id])
    end

    def update
        @type = Type.find(params[:id])
        if @type.update(sector_params)
            flash[:success] = "Sector successfully updated"
            redirect_to types_path
        else
            flash[:error] = "Something went wrong"
            render 'edit' , status: :unprocessable_entity
        end
    end
    private
    def type_params
        params.require(:type).permit(:name)
    end
end