# frozen_string_literal: true

module Admin
  module V1
    class CouponsController < ApiController
      before_action :load_coupon, only: %i(show update destroy)

      def index
        @loading_service = ModelLoadingService.new(Coupon.all, searchable_params)
        @loading_service.call
        @coupons = @loading_service.records
      end

      def create
        @coupon = Coupon.new
        @coupon.attributes = coupon_params
        save_coupon!
      end

      def show; end

      def update
        @coupon.attributes = coupon_params
        save_coupon!
      end

      def destroy
        @coupon.destroy!
      rescue
        render_error fields: @coupon.errors.messages
      end

      private

      def searchable_params
        params.permit({ search: :name }, { order: {} }, :page, :length)
      end

      def load_coupon
        @coupon = Coupon.find(params[:id])
      end

      def coupon_params
        return {} unless params.has_key?(:coupon)
        params.require(:coupon).permit(:id, :name, :code, :status,
                                       :discount_value, :max_use,
                                       :due_date)
      end

      def save_coupon!
        @coupon.save!
        render :show
      rescue
        render_error fields: @coupon.errors.messages
      end
    end
  end
end
