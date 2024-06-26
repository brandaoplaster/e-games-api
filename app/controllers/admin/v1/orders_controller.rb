# frozen_string_literal: true

module Admin::V1
  class OrdersController < ApiController
    def index
      @loading_service = Admin::ModelLoadingService.new(Order.all, searchable_params)
      @loading_service.call
      @orders = @loading_service.records
    end

    def show
      @order = Order.find(params[:id])
    end

    private

    def searchable_params
      params.permit({ order: {} }, :page, :length)
    end
  end
end
