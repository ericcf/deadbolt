require 'spec_helper'

describe Deadbolt::UsersController do

  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/users" }.
        should route_to(:controller => "deadbolt/users", :action => "index") 
    end

    it "recognizes and generates #edit" do
      { :get => "/users/1/edit" }.
        should route_to(:controller => "deadbolt/users", :action => "edit", :id => "1") 
    end

    it "recognizes and generates #update" do
      { :put => "/users/1" }.
        should route_to(:controller => "deadbolt/users", :action => "update", :id => "1") 
    end

    it "recognizes and generates #update_all" do
      { :put => "/users/update_all" }.
        should route_to(:controller => "deadbolt/users", :action => "update_all") 
    end
  end
end
