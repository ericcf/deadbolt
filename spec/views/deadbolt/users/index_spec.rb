require 'spec_helper'

describe "deadbolt/users/index" do

  before(:each) do
    @users = assign(:users, [
      mock_model(Deadbolt::User, :email => "foo@bar.com", :admin? => true,
        :roles => []),
      mock_model(Deadbolt::User, :email => "foo@baz.com", :admin? => false,
        :roles => [mock_model(Deadbolt::Role, :name => "chef")])
    ])
    render
  end

  it "renders a list of users with checkboxes for the admin attribute" do
    rendered.should have_selector("ol") do |list|
      list.should have_selector("li") do |item|
        item.should have_selector("label", :content => @users.first.email)
        item.should have_selector("input", :type => "checkbox",
          :name => "deadbolt_users[#{@users.first.id}][admin]")
      end
      list.should have_selector("li") do |item|
        item.should have_selector("label", :content => @users.second.email)
        item.should have_selector("input", :type => "checkbox",
          :name => "deadbolt_users[#{@users.second.id}][admin]")
      end
    end
  end

  it "renders roles assigned to each user" do
    rendered.should have_selector("li") do |item|
      item.should contain(@users.second.roles.first.name)
    end
  end
end
