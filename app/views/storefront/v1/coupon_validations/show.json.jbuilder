# frozen_string_literal: true

json.coupon do
  json.call(@coupon, :id, :code, :discount_value)
end
