# frozen_string_literal: true

module Storefront
  module V1
    class ApiController < ApplicationController
      include Authenticable
      include SimpleErrorRenderable
      self.simple_error_partial = "shared/simple_error"
    end
  end
end
