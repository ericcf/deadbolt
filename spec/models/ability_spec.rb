require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  context "unauthenticated user" do

    it { should_not be_able_to(:manage, :all) }
  end

  context "admin user" do

    before(:each) do
      @user = stub("user", :admin? => true, :roles => [])
    end

    subject { Ability.new(@user) }

    it { should be_able_to(:manage, :all) }
  end

  context "user in role with class-level permissions" do

    before(:each) do
      manage_users_permission = stub_model(Deadbolt::Permission,
        :action => "manage", :target_type => "Deadbolt::User")
      role_permission = stub_model(Deadbolt::RolePermission,
        :permission => manage_users_permission, :target_id => nil)
      manager_role = stub_model(Deadbolt::Role,
        :role_permissions => [role_permission])
      @manager = stub_model(Deadbolt::User, :admin? => false)
      @manager.stub!(:roles) { [manager_role] }
    end

    subject { Ability.new(@manager) }

    it { should be_able_to(:manage, Deadbolt::User) }
  end

  context "user in role with object-level permissions" do

    before(:each) do
      @manageable_user = stub_model(Deadbolt::User)
      manage_user_permission = stub_model(Deadbolt::Permission,
        :action => "manage", :target_type => "Deadbolt::User")
      role_permission = stub_model(Deadbolt::RolePermission,
        :target => @manageable_user)
      role_permission.stub!(:permission) { manage_user_permission }
      assistant_role = stub_model(Deadbolt::Role,
        :role_permissions => [role_permission])
      @assistant = stub_model(Deadbolt::User,:admin? => false)
      @assistant.stub!(:roles) { [assistant_role] }
    end

    subject { Ability.new(@assistant) }

    it { should be_able_to(:manage, @manageable_user) }
  end
end
