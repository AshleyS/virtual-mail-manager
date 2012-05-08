require 'spec_helper'

describe "Domains" do
  before(:each) do
    visit root_path
    current_path.should eq(log_in_path)

    fill_in "Username", with: "sysadmin"
    fill_in "Password", with: "welcome"
    click_button "Log in"

    current_path.should eq(root_path)

    d1 = Domain.new(name: "example.com", max_mailboxes: -1, max_mailaliases: -1)
    d1.save!
  end

  it "should display list of domains" do
    visit domains_path
    current_path.should eq(domains_path)
  end

  it "should filter on searches" do
    visit domains_path
    current_path.should eq(domains_path)

    fill_in "search", with: "example"
    click_button "Search"
    current_path.should eq(domains_path)

    find_field("search").value.should eq("example")

    page.should have_content("example.com")
  end

  it "should prevent duplicate domains" do
    visit new_domain_path
    current_path.should eq(new_domain_path)

    fill_in "domain_name", with: "example.com"
    fill_in "domain_max_mailboxes", with: "-1"
    fill_in "domain_max_mailboxes", with: "-1"
    click_button "Create Domain"

    page.should have_content("Name has already been taken")
  end

  it "should require mailbox and mailalias number values" do
    visit new_domain_path
    current_path.should eq(new_domain_path)

    fill_in "domain_name", with: "require.mailbox.and.mailalias.com"
    click_button "Create Domain"

    page.should have_content("Max mailboxes can't be blank")
    page.should have_content("Max mailboxes is not a number")
    page.should have_content("Max mailaliases can't be blank")
    page.should have_content("Max mailaliases is not a number")

    fill_in "domain_max_mailboxes", with: "abc"
    fill_in "domain_max_mailaliases", with: "def"
    click_button "Create Domain"

    page.should have_content("Max mailboxes is not a number")
    page.should have_content("Max mailaliases is not a number")

    fill_in "domain_max_mailboxes", with: "10"
    fill_in "domain_max_mailaliases", with: "20"
    click_button "Create Domain"

    page.should have_content("Domain was successfully created")
  end

  it "should delete domain" do
    visit domains_path
    page.should have_content("Total domains: 1")
    click_link "Delete_icon"

    page.status_code.should eq(200)

    page.should_not have_content("example.com")
    page.should have_content("Total domains: 0")
  end

  it "should only accept numbers in default mailbox quota" do
    visit new_domain_path
    current_path.should eq(new_domain_path)

    fill_in "domain_name", with: "default.mailbox.quota.com"
    fill_in "domain_max_mailboxes", with: 10
    fill_in "domain_max_mailaliases", with: 10
    fill_in "domain_default_mailbox_quota", with: "abc"
    click_button "Create Domain"

    page.should have_content("Default mailbox quota is not a number")

    fill_in "domain_default_mailbox_quota", with: 2048
    click_button "Create Domain"

    page.should have_content("Domain was successfully created")
  end
end
