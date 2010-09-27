require 'spec_helper'

describe Deadbolt::User do

  before(:each) do
    @valid_attributes = {
      :email => "#{Deadbolt::User.count}@def.ghi",
      :password => "abcdef",
      :password_confirmation => "abcdef"
    }
    @user = Deadbolt::User.create(@valid_attributes)
    @user.should be_valid
  end

  # database

  it { should have_db_column(:admin).with_options(:default => false) }

  # associations
  
  it { should have_many(:role_assignments).dependent(:destroy) }

  it { should have_many(:roles).through(:role_assignments) }

  # mass assignment

  it { should allow_mass_assignment_of(:role_ids) }

  # methods
  
  ## class
  
  describe "#update_each_admin(:users_admin_attributes)" do

    it "converts specified users to admins" do
      mock_user = mock_model(Deadbolt::User)
      Deadbolt::User.stub!(:all).and_return([mock_user])
      mock_user.should_receive(:update_attribute).with(:admin, true)
      Deadbolt::User.update_each_admin({ mock_user.id => { :admin => true } })
    end

    it "removes admin status from unspecified users" do
      mock_user = mock_model(Deadbolt::User)
      Deadbolt::User.stub!(:all).and_return([mock_user])
      mock_user.should_receive(:update_attribute).with(:admin, false)
      Deadbolt::User.update_each_admin({})
    end
  end
end
