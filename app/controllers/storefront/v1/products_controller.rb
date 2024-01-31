# frozen_string_literal: true

module Storefront::V1
  class ProductsController < ApplicationController
    def index
      @products = Storefront::ProductsFilterService.new(search_params)
      @products.call
    end

    def show
      @product = Product.find(params[:id])
    end

    private

    def search_params
      params.permit(:search, :productable, :page,
                    :length, order: {}, category_ids: [], price: [:min, :max],
                             release_date: [:min, :max]).merge(productable: :game)
    end
  end
end
