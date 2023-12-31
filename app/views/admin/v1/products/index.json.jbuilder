# frozen_string_literal: true

json.products do
  json.array! @products do |product|
    json.partial! product
    json.partial! product.productable
  end
end
