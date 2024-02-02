# frozen_string_literal: true

module Storefront::V1
  class CategoriesController < ApplicationController
    def index
      @categories = Category.order(:name)
    end
  end
end
