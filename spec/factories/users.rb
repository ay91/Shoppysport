FactoryGirl.define do
  factory :user do
    email "user@email.com"
    name "bob"
    password "password"

    trait :sequenced_email do
      sequence(:email) { |n| "user#{n}@email.com" }
    end

    trait :sequenced_name do
      sequence(:name) { |n| "name#{n}" }
    end

    trait :admin do
      admin true
      sequence(:email) { |n| "admin#{n}@email.com" }
      sequence(:name) { |n| "admin#{n}" }
    end
  end
end
