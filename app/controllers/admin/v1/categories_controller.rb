# frozen_string_literal: true

module Admin
  module V1
    class CategoriesController < ApiController
      def index
        @categories = Category.all
      end

      def create
        @category = Category.new
        @category.attributes = category_params
        @category.save!
        render(:show)
      rescue
        render_error(fields: @category.errors.messages)
      end

      private

      def category_params
        return {} unless params.has_key?(:category)

        params.require(:category).permit(:id, :name)
      end
    end
  end
end
