require 'spec_helper'

describe Deadbolt::RolesController do

  def mock_role(stubs={})
    @mock_role ||= mock_model(Deadbolt::Role, stubs).as_null_object
  end

  before(:each) do
    controller.should_receive(:authenticate_user!)
  end

  describe "GET index" do

    before(:each) do
      Deadbolt::Role.stub!(:all).and_return([mock_role])
      controller.should_receive(:authorize!).with(:read, Deadbolt::Role)
      get :index
    end
    
    it { assigns(:roles).should eq([mock_role]) }
  end

  describe "GET show" do

    context "the requested role is found" do

      before(:each) do
        Deadbolt::Role.stub!(:find).with(mock_role.id).
          and_return(mock_role)
        controller.should_receive(:authorize!).with(:read, mock_role)
        get :show, :id => mock_role.id
      end

      it { assigns(:role).should eq(mock_role) }
    end

    context "the requested role is not found" do

      before(:each) do
        Deadbolt::Role.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, :id => mock_role.id
      end

      it { flash[:error].should == "Error: requested role not found" }

      it { should redirect_to(roles_path) }
    end
  end

  describe "GET new" do

    before(:each) do
      Deadbolt::Role.should_receive(:new).and_return(mock_role)
      controller.should_receive(:authorize!).with(:create, Deadbolt::Role)
      get :new
    end

    it { assigns(:role).should eq(mock_role) }
  end

  describe "POST create" do

    before(:each) do
      controller.should_receive(:authorize!).with(:create, Deadbolt::Role)
    end

    context "always" do

      before(:each) do
        Deadbolt::Role.should_receive(:new).
          with("these" => :params).
          and_return(mock_role)
        post :create, :deadbolt_role => { :these => :params }
      end

      it { assigns(:role).should eq(mock_role) }
    end

    context "with valid parameters" do

      before(:each) do
        Deadbolt::Role.stub!(:new).and_return(mock_role(:save => true))
        post :create
      end

      it { should redirect_to(role_path(mock_role)) }
    end

    context "with invalid parameters" do

      before(:each) do
        Deadbolt::Role.stub!(:new).and_return(mock_role(:save => false))
        post :create
      end

      it { should render_template(:new) }
    end
  end

  describe "GET edit" do

    context "the role is found" do

      before(:each) do
        Deadbolt::Role.stub!(:find).and_return(mock_role)
        controller.should_receive(:authorize!).with(:update, mock_role)
        get :edit, :id => mock_role.id
      end

      it { assigns(:role).should eq(mock_role) }

      it { should render_template(:edit) }
    end

    context "the role is not found" do

      before(:each) do
        Deadbolt::Role.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
        get :edit, :id => mock_role.id
      end

      it { flash[:error].should == "Error: requested role not found" }

      it { should redirect_to(roles_path) }
    end
  end

  describe "PUT update" do

    context "the requested role is found" do
    
      before(:each) do
        Deadbolt::Role.stub!(:find).and_return(mock_role)
        controller.should_receive(:authorize!).with(:update, mock_role)
      end

      context "always" do

        it "updates with the provided attributes" do
          mock_role.should_receive(:update_attributes).
            with("these" => :params)
          put :update, :id => mock_role.id,
            :deadbolt_role => { :these => :params }
        end
      end

      context "it updates successfully" do

        before(:each) do
          mock_role.stub!(:update_attributes).and_return(true)
          put :update, :id => mock_role.id
        end

        it { should redirect_to(role_path(mock_role)) }
      end

      context "it does not update successfully" do

        before(:each) do
          mock_role.stub!(:update_attributes).and_return(false)
          put :update, :id => mock_role.id
        end

        it { should render_template(:edit) }
      end
    end

    context "the role is not found" do

      before(:each) do
        Deadbolt::Role.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
        put :update, :id => mock_role.id
      end

      it { flash[:error].should == "Error: requested role not found" }

      it { should redirect_to(roles_path) }
    end
  end

  describe "DELETE destroy" do

    context "the requested role is found" do

      before(:each) do
        Deadbolt::Role.stub!(:find).and_return(mock_role)
        controller.should_receive(:authorize!).with(:destroy, mock_role)
      end

      context "and destroyed successfully" do

        before(:each) do
          mock_role.should_receive(:destroy).and_return(true)
          delete :destroy, :id => mock_role.id
        end

        it { flash[:notice].should == "Successfully deleted role" }

        it { should redirect_to(roles_path) }
      end

      context "and not destroyed successfully" do

        before(:each) do
          mock_role.should_receive(:destroy).and_return(false)
          delete :destroy, :id => mock_role.id
        end

        it { flash[:error].should == "Error: failed to delete role" }

        it { should redirect_to(roles_path) }
      end
    end

    context "the requested role is not found" do

      before(:each) do
        Deadbolt::Role.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
        delete :destroy, :id => mock_role.id
      end

      it { flash[:error].should == "Error: requested role not found" }

      it { should redirect_to(roles_path) }
    end
  end
end
