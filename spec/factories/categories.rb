FactoryGirl.define do
  factory :category do
      name "category"

    trait :sequenced_name do
      sequence(:name) {|n| "category-#{n}"}
    end
  end
end
