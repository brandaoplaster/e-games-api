FactoryBot.define do
  factory :coupon do
    sequence(:name) { |n| "Coupon #{n}"}
    code { Faker::Commerce.unique.promotion_code(digits: 4) }
    status { %i(active inactive).sample }
    discount_value { rand(1..99) }
    max_use { rand(1..100) }
    due_date { 3.days.from_now }
  end
end
