# frozen_string_literal: true

json.products do
  json.array! @products.records do |product|
    json.call(product, :id, :name, :description)
    json.price product.price.to_f
    json.image_url rails_blob_url(product.image)
    json.categories product.categories.pluck(:name)
  end
end

json.meta do
  json.partial! "shared/pagination", pagination: @products.pagination
end
