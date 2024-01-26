# frozen_string_literal: true

json.categories do
  json.array!(@categories, :id, :name)
end

json.meta do
  json.partial! "shared/pagination", pagination: @loading_service.pagination
end
