FactoryGirl.define do
  factory :user, aliases: [:assignee, :owner, :creator] do
    sequence(:email) { |n| "user#{n}@maldoror.tk" }
    sequence(:username) { |n| "user#{n}" }
    password "password"
  end

  factory :task do
    association :assignee
    association :project
    association :creator
    association :milestone
    priority :normal
    name "Do something"
    details "You better do something! Do it!"
  end

  factory :milestone do
    title "Hard Deadline"
    association :project
  end

  factory :project do
    name "Project factory"
    association :owner
  end

  factory :comment do
    association :task
    association :user
    text "This is my comment"
  end

  factory :settings do
    time_zone "Novosibirsk"
  end
end
