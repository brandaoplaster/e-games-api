# frozen_string_literal: true

json.coupons do
  json.array!(@coupons, :id, :name, :code, :status, :discount_value, :max_use, :due_date)
end

json.meta do
  json.partial! "shared/pagination", pagination: @loading_service.pagination
end
