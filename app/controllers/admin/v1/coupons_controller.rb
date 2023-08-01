# frozen_string_literal: true

module Admin
  module V1
    class CouponsController < ApiController
      def index
        @coupons = Coupon.all
      end
    end
  end
end
