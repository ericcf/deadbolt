require 'spec_helper'

describe "deadbolt/shared_partials/_admin_menu" do

  before(:each) do
    view.stub!(:can?).and_return(false)
  end

  context "can read Deadbolt::User" do

    before(:each) do
      view.stub!(:can?).with(:read, Deadbolt::User).and_return(true)
      render
    end

    it { rendered.should have_selector("a", :href => users_path,
      :content => "Users") }
  end

  context "can read Deadbolt::Role" do

    before(:each) do
      view.stub!(:can?).with(:read, Deadbolt::Role).and_return(true)
      render
    end

    it { rendered.should have_selector("a", :href => roles_path,
      :content => "Roles") }
  end

  context "can read Deadbolt::Permission" do

    before(:each) do
      view.stub!(:can?).with(:read, Deadbolt::Permission).and_return(true)
      render
    end

    it { rendered.should have_selector("a", :href => permissions_path,
      :content => "Permissions") }
  end
end
