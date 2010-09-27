require 'spec_helper'

describe "deadbolt/users/edit" do

  before(:each) do
    @user = assign(:user, stub_model(Deadbolt::User))
    render
  end

  it "renders fields for assigning roles" do
    rendered.should have_selector("form input",
      :name => "deadbolt_user[role_ids][]")
  end
end
