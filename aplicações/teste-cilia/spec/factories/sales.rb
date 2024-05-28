FactoryBot.define do
  factory :sale do
    status { 'pending' }
    association :customer

    transient do
      sale_products_count { 1 }
    end

    after(:create) do |sale, evaluator|
      create_list(:sale_product, evaluator.sale_products_count, sale: sale)
    end

    trait :completed do
      status { 'completed' }
    end

    trait :canceled do
      status { 'canceled' }
    end
  end
end