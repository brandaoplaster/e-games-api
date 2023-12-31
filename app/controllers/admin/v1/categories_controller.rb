# frozen_string_literal: true

module Admin
  module V1
    class CategoriesController < ApiController
      before_action :laod_category, only: [:update, :destroy, :show]

      def index
        @categories = load_categories
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

      def load_categories
        permitted = params.permit({search: :name}, {order: {}}, :page, :length)
        Admin::ModelLoadingService.new(Category.all, permitted).call
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
