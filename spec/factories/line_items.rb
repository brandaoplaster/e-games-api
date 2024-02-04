FactoryBot.define do
  factory :line_item do
    quantity { 1 }
    payed_price { Faker::Commerce.price(range: 100.0..200.0) }
    order
    product
  end
end
