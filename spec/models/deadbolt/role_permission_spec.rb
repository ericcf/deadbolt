require 'spec_helper'

describe Deadbolt::RolePermission do

  before(:each) do
    mock_role = stub_model(Deadbolt::Role, :valid? => true)
    Deadbolt::Role.stub!(:find).with(mock_role.id, anything) { mock_role }
    mock_permission = stub_model(Deadbolt::Permission, :valid? => true)
    Deadbolt::Permission.stub!(:find).with(mock_permission.id, anything).
      and_return(mock_permission)
    @valid_attributes = {
      :role => mock_role,
      :permission => mock_permission
    }
    @role_permission = Deadbolt::RolePermission.create(@valid_attributes)
    @role_permission.should be_valid
  end

  # database

  it { should have_db_column(:role_id).with_options(:null => false) }

  it { should have_db_column(:permission_id).with_options(:null => false) }

  it { should have_db_index(:role_id) }

  it { should have_db_index(:permission_id) }

  it { should have_db_index(:target_id) }

  # associations

  it { should belong_to(:role) }

  it { should belong_to(:permission) }

  # validations

  it { should validate_presence_of(:role) }

  it { should validate_presence_of(:permission) }

  it { should validate_associated(:role) }

  it { should validate_associated(:permission) }

  # methods

  describe ".target" do

    context "target_id is blank" do

      it "returns nil" do
        @role_permission.update_attribute(:target_id, nil)
        @role_permission.target.should be_nil
      end
    end

    context "target_id refers to a record of type permission.target_type" do

      it "returns the record" do
        mock_permission = stub_model(Deadbolt::Permission)
        Deadbolt::Permission.stub!("find").with(mock_permission.id).
          and_return(mock_permission)
        @role_permission.permission.stub!(:target_type).
          and_return("Deadbolt::Permission")
        @role_permission.update_attribute(:target_id, mock_permission.id)
        @role_permission.target.should eq(mock_permission)
      end
    end
  end
end
