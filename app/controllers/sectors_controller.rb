class  SectorsController < ApplicationController
    before_action :require_user 
    before_action :require_admin_recruiter, except: [:index, :show]

    def new
        @sector = Sector.new
    end

    def create
        @sector= Sector.new(sector_params)
        @sector.user = current_user
        if @sector.save
          flash[:success] = "Sector successfully created"
          redirect_to sectors_path
        else
          render 'new' , status: :unprocessable_entity
        end
    end
    
    def show
        # debugger
        @sector = Sector.find(params[:id])
    end

    def index
        @sectors = Sector.all
    end

    def destroy
        @sector = Sector.find(params[:id])
        @sector.destroy
        flash[:danger] = "Sector successfully deleted"
        redirect_to sectors_path, status: :see_other
    end

    def edit
        @sector = Sector.find(params[:id])
    end

    def update
        @sector = Sector.find(params[:id])
        @sector.user = current_user
        if @sector.update(sector_params)
            flash[:success] = "Sector successfully updated"
            redirect_to sectors_path
        else
            render 'edit' , status: :unprocessable_entity
        end
    end
    private
    def sector_params
        params.require(:sector).permit(:name)
    end
end