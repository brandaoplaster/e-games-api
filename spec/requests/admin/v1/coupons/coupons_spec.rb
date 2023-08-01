require 'rails_helper'

RSpec.describe "Admin::V1::Coupons", type: :request do
  let(:user) { create(:user) }

  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 5) }

    it "returns all coupons" do
      get url, headers: auth_header(user)
      coupon_attributes = %i(id name code status discount_value max_use due_date)
      expect(body_json["coupons"]).to contain_exactly *coupons.as_json(only: coupon_attributes)
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end
end
