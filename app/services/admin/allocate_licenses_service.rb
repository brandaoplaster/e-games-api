# frozen_string_literal: true

module Admin
  class AllocateLicensesService
    def initialize(line_item)
      @line_item = line_item
    end

    def call
      licenses = @line_item.product.productable.licenses.where(status: :available).take(@line_item.quantity)
      License.transaction { update_licenses(licenses) }
    end

    private

    def update_licenses(licenses)
      licenses.map { |license| license.attributes = { status: :in_use, line_item: @line_item } }
      licenses.each { |license| license.save! }
    end
  end
end
