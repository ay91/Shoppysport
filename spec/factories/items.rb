FactoryGirl.define do
  factory :item do
    title "item"
    price 100
    description "description"
    category_id {create(:category).id}

    trait :with_image do
      File.new("#{Rails.root}/app/assets/images/racket-1.jpg")
    end

    trait :sequenced_title do
      sequence(:title) {|n| "title-#{n}"}
    end

    trait :sequenced_price do
      100
    end

    trait :sequenced_description do
      sequence(:description) {|n| "description-#{n}"}
    end
  end
end
