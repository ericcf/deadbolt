require 'spec_helper'

describe Deadbolt::RolePermission do

  before(:each) do
    role = mock_model(Deadbolt::Role, :valid? => true)
    Deadbolt::Role.stub!(:find).with(role.id, anything).and_return(role)
    permission = mock_model(Deadbolt::Permission, :valid? => true)
    Deadbolt::Permission.stub!(:find).with(permission.id, anything).
      and_return(permission)
    @valid_attributes = {
      :role => role,
      :permission => permission,
      :target_id => 1
    }
    @role_permission = Deadbolt::RolePermission.create(@valid_attributes)
    @role_permission.should be_valid
  end

  # database

  it { should have_db_column(:role_id).with_options(:null => false) }

  it { should have_db_column(:permission_id).with_options(:null => false) }

  # associations

  it { should belong_to(:role) }

  it { should belong_to(:permission) }

  # validations

  it { should validate_presence_of(:role) }

  it { should validate_presence_of(:permission) }

  it { should validate_associated(:role) }

  it { should validate_associated(:permission) }
end
