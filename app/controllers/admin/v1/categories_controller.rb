# frozen_string_literal: true

module Admin
  module V1
    class CategoriesController < ApiController
      before_action :laod_category, only: [:update, :destroy, :show]

      def index
        @loading_service = ModelLoadingService.new(Category.all, searchable_params)
        @loading_service.call
        @categories = @loading_service.records
      end

      def create
        @category = Category.new
        @category.attributes = category_params
        save_category!
      end

      def update
        @category.attributes = category_params
        save_category!
      end

      def show; end

      def destroy
        @category.destroy!
      rescue
        render_error(fields: @category.errors.messages)
      end

      private

      def laod_category
        @category = Category.find(params[:id])
      end

      def searchable_params
        params.permit({ search: :name}, { order: {}}, :page, :length)
      end

      def category_params
        return {} unless params.has_key?(:category)
        params.require(:category).permit(:id, :name)
      end

      def save_category!
        @category.save!
        render :show
      rescue
        render_error(fields: @category.errors.messages)
      end
    end
  end
end
