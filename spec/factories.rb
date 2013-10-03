FactoryGirl.define do
  factory :user, aliases: [ :assignee ] do
    sequence(:email) { |n| "user#{n}@maldoror.tk" }
    password "password"
  end

  factory :task do
    association :assignee
    status false
    name "Do something"
    details "You better do something immediately or I will get unstable and want to drink again"
  end
end
