# frozen_string_literal: true

module Storefront::V1
  class HomeController < ApplicationController
    def index
      @loader_service = Storefront::HomeLoaderService.new
      @loader_service.call
      @loader_service
    end
  end
end
