require 'spec_helper'

describe Deadbolt::PermissionsController do

  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/permissions" }.
        should route_to(:controller => "deadbolt/permissions", :action => "index") 
    end
  end
end
