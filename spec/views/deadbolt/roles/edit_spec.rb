require 'spec_helper'

describe "deadbolt/roles/edit" do

  it "renders the form partial" do
    assign(:role, stub_model(Deadbolt::Role))
    render
    should render_template(:partial => "_form")
  end
end
