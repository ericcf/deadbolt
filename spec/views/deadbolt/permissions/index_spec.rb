require 'spec_helper'

describe "deadbolt/permissions/index" do

  before(:each) do
    assign(:permissions, [
      mock_model(Deadbolt::Permission, :action => "manage",
        :target_type => "Sprocket"),
      mock_model(Deadbolt::Permission, :action => "update",
        :target_type => "Widget")
    ])
    render
  end

  it "renders a list of permissions" do
    rendered.should have_selector("ul") do |list|
      list.should have_selector("li", :content => "can manage Sprockets")
      list.should have_selector("li", :content => "can update Widgets")
    end
  end
end
