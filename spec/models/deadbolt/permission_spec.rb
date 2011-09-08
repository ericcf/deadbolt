require 'spec_helper'

describe Deadbolt::Permission do

  #let(:mock_role) { mock_model(Deadbolt::Role, :valid? => true) }
  let(:valid_attributes) { { :action => "manage", :target_type => "Deadbolt::User" } }
  let(:permission) { Deadbolt::Permission.create!(valid_attributes) }

  subject { permission }

  # database
  
  it { should have_db_column(:action).with_options(:null => false) }
  
  it { should have_db_column(:target_type).with_options(:null => false) }

  # associations

  it { should have_many(:role_permissions).dependent(:destroy) }

  it { should have_many(:roles).through(:role_permissions) }

  # validations

  it { should validate_presence_of(:action) }

  it { should validate_presence_of(:target_type) }

  Deadbolt::Permission::Actions.each do |action|
    it { should allow_value(action).for(:action) }
  end

  it { should_not allow_value("untie").for(:action) }

  # methods

  describe ".human_name" do

    it "returns a human readable name for the permission" do
      permission.human_name.should eq("can manage (view, add, modify, delete) Deadbolt::Users")
    end
  end

  describe "When creating an associated role" do

    it "should also create an associated role permission" do
      role = permission.roles.create :name => "Underling"
      role.role_permissions.count.should eq(1)
    end
  end
end
