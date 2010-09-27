require 'spec_helper'

describe "deadbolt/roles/_form" do

  def mock_role(stubs={})
    @mock_role ||= stub_model(Deadbolt::Role)
  end

  context "a new role record" do

    before(:each) do
      assign(:role, mock_role.as_new_record)
      render
    end

    it "renders a form for creating the role" do
      rendered.should have_selector("form", :action => roles_path)
    end
  end

  context "an existing record" do

    before(:each) do
      assign(:role, mock_role)
      render
    end

    it "renders a form for updating the role" do
      rendered.should have_selector("form", :action => role_path(mock_role))
    end
  end

  context "always" do

    before(:each) do
      assign(:role, mock_role)
      render
    end

    it "renders a label and text field for the name" do
      rendered.should have_selector("form") do |form|
        form.should have_selector("label", :content => "Name")
        form.should have_selector("input", :type => "text",
          :name => "deadbolt_role[name]")
      end
    end

    it "renders fields for assigning permissions" do
      rendered.should have_selector("form") do |form|
        form.should have_selector("input",
          :name => "deadbolt_role[permission_ids][]")
      end
    end
  end
end
