require "spec_helper"

describe "Mailboxes model" do

  it "should add new mailboxes from JSON" do
    d1 = FactoryGirl.create(:domain)

    json_example = '
[
  {
    "email":"test1",
    "password":"welcome"
  },
  {
    "email":"test2",
    "password":"welcome"
  },
  {
    "email":"test3",
    "password":"welcome"
  },
  {
    "email":"test4",
    "password":"welcome"
  },
  {
    "email":"test5",
    "password":"welcome"
  },
  {
    "email":"test6",
    "password":"welcome"
  }
]'

    parser = JSON.parse(json_example)

    parser.each do |record|
      d1.mailboxes.new(record).save
    end

    total_mailboxes = Mailbox.all
    total_mailboxes.size.should eq(6)

    total_mailboxes.first.email.should eq("test1")
    total_mailboxes.last.email.should eq("test6")

  end

end
