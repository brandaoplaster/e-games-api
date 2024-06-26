# frozen_string_literal: true

json.orders do
  json.array! @orders.records do |order|
    json.call(order, :id, :status, :total_amount, :payment_type)
  end
end

json.meta do
  json.partial! "shared/pagination", pagination: @loading_service.pagination
end
