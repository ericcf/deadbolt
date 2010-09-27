require 'spec_helper'

describe Deadbolt::RolesController do

  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/roles" }.
        should route_to(:controller => "deadbolt/roles", :action => "index") 
    end

    it "recognizes and generates #show" do
      { :get => "/roles/1" }.
        should route_to(:controller => "deadbolt/roles", :action => "show", :id => "1") 
    end

    it "recognizes and generates #new" do
      { :get => "/roles/new" }.
        should route_to(:controller => "deadbolt/roles", :action => "new") 
    end

    it "recognizes and generates #create" do
      { :post => "/roles" }.
        should route_to(:controller => "deadbolt/roles", :action => "create") 
    end

    it "recognizes and generates #edit" do
      { :get => "/roles/1/edit" }.
        should route_to(:controller => "deadbolt/roles", :action => "edit", :id => "1") 
    end

    it "recognizes and generates #update" do
      { :put => "/roles/1" }.
        should route_to(:controller => "deadbolt/roles", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/roles/1" }.
        should route_to(:controller => "deadbolt/roles", :action => "destroy", :id => "1") 
    end
  end
end
