require 'spec_helper'

describe "deadbolt/roles/index" do

  before(:each) do
    @roles = assign(:roles, [
      mock_model(Deadbolt::Role, :name => "manager"),
      mock_model(Deadbolt::Role, :name => "assistant")
    ])
    view.should_receive(:can?).with(:create, Deadbolt::Role).and_return(true)
    view.should_receive(:can?).with(:update, @roles.first).and_return(true)
    view.should_receive(:can?).with(:update, @roles.second).and_return(true)
    render
  end

  it "renders a link to add a new role" do
    rendered.should have_selector("a", :href => new_role_path,
      :content => "Add Role")
  end

  it "renders a table of roles with links to show and edit them" do
    rendered.should have_selector("table") do |table|
      table.should have_selector("tr") do |row|
        row.should have_selector("td a", :href => role_path(@roles.first),
          :content => @roles.first.name)
        row.should have_selector("td a", :href => edit_role_path(@roles.first),
          :content => "edit")
      end
      table.should have_selector("tr") do |row|
        row.should have_selector("td a", :href => role_path(@roles.second),
          :content => @roles.second.name)
        row.should have_selector("td a", :href => edit_role_path(@roles.second),
          :content => "edit")
      end
    end
  end
end
