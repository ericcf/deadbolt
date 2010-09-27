class Deadbolt::RolesController < ApplicationController

  before_filter :authenticate_user!

  def index
    authorize! :read, Deadbolt::Role
    @roles = Deadbolt::Role.all
  end

  def show
    @role = Deadbolt::Role.find(params[:id])
    authorize! :read, @role

  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Error: requested role not found"
    redirect_to roles_path
  end

  def new
    authorize! :create, Deadbolt::Role
    @role = Deadbolt::Role.new
  end

  def create
    authorize! :create, Deadbolt::Role
    @role = Deadbolt::Role.new(params[:deadbolt_role])

    if @role.save
      return(redirect_to role_path(@role))
    end
    render :new
  end

  def edit
    @role = Deadbolt::Role.find(params[:id])
    authorize! :update, @role

  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Error: requested role not found"
    redirect_to roles_path
  end

  def update
    @role = Deadbolt::Role.find(params[:id])
    authorize! :update, @role

    if @role.update_attributes(params[:deadbolt_role])
      return(redirect_to role_path(@role))
    end
    render :edit

  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Error: requested role not found"
    redirect_to roles_path
  end

  def destroy
    role = Deadbolt::Role.find(params[:id])
    authorize! :destroy, role

    if role.destroy
      flash[:notice] = "Successfully deleted role"
    else
      flash[:error] = "Error: failed to delete role"
    end
    redirect_to roles_path

  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Error: requested role not found"
    redirect_to roles_path
  end
end
