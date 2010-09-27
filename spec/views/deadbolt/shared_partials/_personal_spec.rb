require 'spec_helper'

describe "deadbolt/shared_partials/_personal" do

  context "anonymous user" do

    before(:each) do
      view.stub!(:user_signed_in?).and_return(false)
      render
    end

    it { rendered.should have_selector("a", :href => new_user_session_path,
      :content => "Sign in") }
  end

  context "logged in user" do

    before(:each) do
      view.stub!(:user_signed_in?).and_return(true)
      @mock_user = mock("user", :email => "foo@bar.com")
      view.stub!(:current_user).and_return(@mock_user)
      render
    end

    it { rendered.should contain(@mock_user.email) }

    it { rendered.should have_selector("a",
      :href => edit_user_registration_path, :content => "Preferences") }

    it { rendered.should have_selector("a",
      :href => destroy_user_session_path, :content => "Sign out") }
  end
end
