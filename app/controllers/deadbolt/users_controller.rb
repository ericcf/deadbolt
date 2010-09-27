class Deadbolt::UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    authorize! :read, Deadbolt::User
    @users = Deadbolt::User.all
  end

  def edit
    @user = Deadbolt::User.find(params[:id])
    authorize! :update, @user

  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Error: requested user not found"
    redirect_to users_path
  end

  def update
    @user = Deadbolt::User.find(params[:id])
    authorize! :update, @user

    if @user.update_attributes(params[:deadbolt_user])
      return(redirect_to users_path, :notice => "Successfully updated user")
    end
    render :edit

  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Error: requested user not found"
    redirect_to users_path
  end

  def update_all
    authorize! :update, Deadbolt::User
    Deadbolt::User.update_each_admin(params[:deadbolt_users])
    redirect_to users_path, :notice => "Successfully updated users"
  end
end
