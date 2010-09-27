require 'spec_helper'

describe "deadbolt/roles/new" do

  it "renders the form partial" do
    assign(:role, stub_model(Deadbolt::Role))
    should_render_partial("form")
    render
  end
end
