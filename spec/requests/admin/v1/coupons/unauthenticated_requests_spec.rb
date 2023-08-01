require "rails_helper"

RSpec.describe "Admin v1 coupons without authentication", type: :request do
  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 5) }

    before(:each) { get url }
  end
end
