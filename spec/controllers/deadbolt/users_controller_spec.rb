require 'spec_helper'

describe Deadbolt::UsersController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(Deadbolt::User, stubs)
  end

  before(:each) do
    controller.should_receive(:authenticate_user!)
  end

  describe "GET index" do

    before(:each) do
      Deadbolt::User.stub!(:all).and_return([mock_user])
      controller.should_receive(:authorize!).with(:read, Deadbolt::User)
      get :index
    end

    it { assigns(:users).should eq([mock_user]) }
  end

  describe "GET edit" do

    context "requested user is found" do

      before(:each) do
        Deadbolt::User.stub!(:find).with(mock_user.id).and_return(mock_user)
        controller.should_receive(:authorize!).with(:update, mock_user)
        get :edit, :id => mock_user.id
      end

      it { assigns(:user).should eq(mock_user) }

      it { should render_template(:edit) }
    end

    context "requested user is not found" do

      before(:each) do
        Deadbolt::User.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
        get :edit, :id => 1
      end

      it { flash[:error].should == "Error: requested user not found" }

      it { should redirect_to(users_path) }
    end
  end

  describe "PUT update" do

    context "requested user is found" do

      before(:each) do
        Deadbolt::User.stub!(:find).and_return(mock_user)
        controller.should_receive(:authorize!).with(:update, mock_user)
      end

      context "always" do

        it "updates with the provided attributes" do
          mock_user.should_receive(:update_attributes).
            with("these" => :params)
          put :update, :id => mock_user.id,
            :deadbolt_user => { :these => :params }
        end
      end

      context "it updates successfully" do

        before(:each) do
          mock_user.stub!(:update_attributes).and_return(true)
          put :update, :id => mock_user.id
        end

        it { should redirect_to(users_path) }
      end

      context "it does not update successfully" do

        before(:each) do
          mock_user.stub!(:update_attributes).and_return(false)
          put :update, :id => mock_user.id
        end

        it { should render_template(:edit) }
      end
    end

    context "the user is not found" do

      before(:each) do
        Deadbolt::User.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
        put :update, :id => mock_user.id
      end

      it { flash[:error].should == "Error: requested user not found" }

      it { should redirect_to(users_path) }
    end
  end

  describe "PUT update_all" do

    before(:each) do
      Deadbolt::User.should_receive(:update_each_admin).with("these" => :params)
      controller.should_receive(:authorize!).with(:update, Deadbolt::User)
      put :update_all, :deadbolt_users => { :these => :params }
    end

    it { should redirect_to(users_path) }

    it { flash[:notice].should == "Successfully updated users" }
  end
end
