FactoryGirl.define do
  factory :user, aliases: [ :assignee ] do
    sequence(:email) { |n| "user#{n}@maldoror.tk" }
    password "password"
  end

  factory :task do
    association :assignee
    association :project
    status false
    name "Do something"
    details "You better do something immediately or I will get unstable and want to drink again"
  end

  factory :project do
    name "Project factory"
  end

  factory :comment do
    association :task
    association :user
    text "This is my comment"
  end
end
