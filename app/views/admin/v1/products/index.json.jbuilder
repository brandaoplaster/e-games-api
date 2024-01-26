# frozen_string_literal: true

json.products do
  json.array! @products do |product|
    json.partial! product
    json.partial! product.productable
  end
end

json.meta do
  json.partial! "shared/pagination", pagination: @loading_service.pagination
end
