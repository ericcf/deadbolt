require 'spec_helper'

describe Deadbolt::RoleAssignment do

  before(:each) do
    user = mock_model(Deadbolt::User, :valid? => true)
    Deadbolt::User.stub!(:find).with(user.id, anything).and_return(user)
    role = mock_model(Deadbolt::Role, :valid? => true)
    Deadbolt::Role.stub!(:find).with(role.id, anything).and_return(role)
    @valid_attributes = {
      :user => user,
      :role => role
    }
    @role_assignment = Deadbolt::RoleAssignment.create(@valid_attributes)
    @role_assignment.should be_valid
  end

  # database

  it { should have_db_column(:user_id).with_options(:null => false) }

  it { should have_db_column(:role_id).with_options(:null => false) }

  it { should have_db_index([:role_id, :user_id]).unique(true) }

  # associations

  it { should belong_to(:user) }

  it { should belong_to(:role) }

  # validations

  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:role) }

  it { should validate_associated(:user) }

  it { should validate_associated(:role) }

  it { should validate_uniqueness_of(:role_id).scoped_to(:user_id) }
end
