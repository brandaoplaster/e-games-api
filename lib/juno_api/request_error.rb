# frozen_string_literal: true

module JunoApi
  class RequestError < StandardError
    attr_reader :response

    def initialize(message, error = nil)
      @error = error
      super(message)
    end
  end
end
