require 'spec_helper'

describe "deadbolt/roles/show" do

  before(:each) do
    @permission = mock_model(Deadbolt::Permission, :human_name => "can foo")
    @role = assign(:role, mock_model(Deadbolt::Role, :name => "manager",
      :permissions => [@permission]))
    render
  end

  it "renders the name" do
    rendered.should have_selector("h2", :content => @role.name)
  end

  it "renders a list of permissions" do
    rendered.should have_selector("ul li", :content => @permission.human_name)
  end
end
