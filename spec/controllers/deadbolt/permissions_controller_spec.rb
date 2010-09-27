require 'spec_helper'

describe Deadbolt::PermissionsController do

  def mock_permission(stubs={})
    @mock_permission ||= mock_model(Deadbolt::Permission, stubs)
  end

  before(:each) do
    controller.should_receive(:authenticate_user!)
  end

  describe "GET index" do

    before(:each) do
      Deadbolt::Permission.stub!(:all).and_return([mock_permission])
      controller.should_receive(:authorize!).
        with(:read, Deadbolt::Permission)
      get :index
    end

    it { assigns(:permissions).should eq([mock_permission]) }
  end
end
