require 'spec_helper'

describe "Common" do
  describe "GET /" do
    it "should redirect to login" do
      visit root_path
      current_path.should eq(log_in_path)

      fill_in "Username", with: "sysadmin"
      fill_in "Password", with: "welcome"
      click_button "Log in"

      current_path.should eq(root_path)
    end
  end
end
