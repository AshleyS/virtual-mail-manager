FactoryGirl.define do
  factory :domain do
    sequence(:name) { |n| "test#{n}.com" }
    max_mailboxes 10
    max_mailaliases 10
  end

  factory :mailbox do
    sequence(:email) { |n| "test#{n}" }
    password "welcome"
    domain_id "1"
  end

  factory :user do
    username "user"
    password "welcome"
  end

  factory :admin, class: User do
    username "admin"
    password "welcome"
    admin true
  end
end
