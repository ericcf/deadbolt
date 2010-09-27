class Deadbolt::PermissionsController < ApplicationController

  before_filter :authenticate_user!

  def index
    authorize! :read, Deadbolt::Permission
    @permissions = Deadbolt::Permission.all
  end
end
