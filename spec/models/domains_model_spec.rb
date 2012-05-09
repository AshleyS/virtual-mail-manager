require "spec_helper"

describe "Domains model" do
  it "should filter" do
    30.times { FactoryGirl.create(:domain) }

    search = Domain.search("test1")
    search.all.size.should eq(11)

    search = Domain.search("test2")
    search.all.size.should eq(11)

    search = Domain.search("test3")
    search.all.size.should eq(2)
  end

  it "should paginate" do
    FactoryGirl.reload

    25.times { FactoryGirl.create(:domain) }
    Domain.all.size.should eq(25)

    paginate = Domain.paginate(per_page: 5, page: 1)
    paginate.all.size.should eq(5)

    paginate = Domain.paginate(per_page: 15, page: 2)
    paginate.all.size.should eq(10)

    last_record = Domain.order(:id).reverse_order
    last_record.first.name.should eq("test25.com")
  end

  it "should search and paginate" do
    FactoryGirl.reload

    20.times { FactoryGirl.create(:domain) }
    domains = Domain.search("test1").paginate(per_page: 2, page: 3)

    domains.all.first.name.should eq("test13.com")
  end
end
