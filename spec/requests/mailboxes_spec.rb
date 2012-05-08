require 'spec_helper'

describe "Mailboxes" do
  before(:each) do
    visit root_path
    current_path.should eq(log_in_path)

    fill_in "Username", with: "sysadmin"
    fill_in "Password", with: "welcome"
    click_button "Log in"

    current_path.should eq(root_path)
  end

  it "should use domain's default mailbox quota" do
    d1 = Domain.new(name: "example.com", max_mailboxes: -1, max_mailaliases: -1, default_mailbox_quota: 2048)
    d1.save!

    visit new_domain_mailbox_path(d1)
    current_path.should eq("/domains/1/mailboxes/new")

    find_field("mailbox_quota_kb").value.should eq("2048")
  end

  it "should use existing mailbox default mailbox quota" do
    d1 = Domain.new(name: "example.com", max_mailboxes: -1, max_mailaliases: -1, default_mailbox_quota: 2048)
    d1.save!

    visit new_domain_mailbox_path(d1)

    fill_in "mailbox_email", with: "example"
    fill_in "mailbox_password", with: "welcome"
    fill_in "mailbox_quota_kb", with: 1024

    click_button "Create Mailbox"
    page.should have_content("Mailbox was successfully created")

    click_link "Edit_icon_large"
    find_field("mailbox_quota_kb").value.should eq("1024")
  end
end
