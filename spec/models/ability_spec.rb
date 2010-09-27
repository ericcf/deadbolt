require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  context "unauthenticated user" do

    it { should_not be_able_to(:manage, :all) }
  end

  context "admin user" do

    before(:each) do
      user = stub("user", :admin? => true, :roles => [])
      @ability = Ability.new(user)
    end

    it { @ability.should be_able_to(:manage, :all) }
  end

  context "user in role with class-level permissions" do

    before(:each) do
      manage_users_permission = mock_model(Deadbolt::Permission,
        :action => "manage", :target_type => "Deadbolt::User")
      role_permission = mock_model(Deadbolt::RolePermission,
        :permission => manage_users_permission, :target_id => nil)
      manager_role = mock_model(Deadbolt::Role,
        :role_permissions => [role_permission])
      manager = mock_model(Deadbolt::User, :roles => [manager_role],
        :admin? => false)
      @ability = Ability.new(manager)
    end

    it { @ability.should be_able_to(:manage, Deadbolt::User) }
  end

  context "user in role with object-level permissions" do

    before(:each) do
      @manageable_user = mock_model(Deadbolt::User)
      manage_user_permission = mock_model(Deadbolt::Permission,
        :action => "manage", :target_type => "Deadbolt::User")
      role_permission = mock_model(Deadbolt::RolePermission,
        :permission => manage_user_permission,
        :target_id => @manageable_user.id)
      assistant_role = mock_model(Deadbolt::Role,
        :role_permissions => [role_permission])
      assistant = mock_model(Deadbolt::User, :roles => [assistant_role],
        :admin? => false)
      @ability = Ability.new(assistant)
    end

    it { @ability.should be_able_to(:manage, @manageable_user) }
  end
end
