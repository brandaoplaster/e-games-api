require "rails_helper"

RSpec.describe "Admin v1 Product without authentication", type: :request do
  context "GET /products" do
    let(:url) { "/admin/v1/products" }
    let!(:products) { create_list(:product, 5) }

    before(:each) { get url }

    include_examples "unauthenticated access"
  end
end
