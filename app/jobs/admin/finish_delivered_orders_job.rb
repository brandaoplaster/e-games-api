# frozen_string_literal: true

module Admin
  class FinishDeliveredOrdersJob < ApplicationJob
    queue_as :default

    def perform
      FinishDeliveredOrdersService.call
    end
  end
end
