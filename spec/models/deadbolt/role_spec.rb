require 'spec_helper'

describe Deadbolt::Role do

  before(:each) do
    @valid_attributes = {
      :name => "valid name"
    }
    @role = Deadbolt::Role.create(@valid_attributes)
    @role.should be_valid
  end

  # database

  it { should have_db_column(:name).with_options(:null => false) }

  it { should have_db_index(:name).unique(true) }

  # associations

  it { should have_many(:role_assignments).dependent(:destroy) }

  it { should have_many(:users).through(:role_assignments) }

  it { should have_many(:role_permissions).dependent(:destroy) }

  it { should have_many(:permissions).through(:role_permissions) }

  # validations
  
  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:name).case_insensitive }

  # attribute cleaning

  it { should clean_text_attribute(:name) }
end
