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

  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }

    context "with valid params" do
      let(:coupon_params) { { coupon: attributes_for(:coupon) }.to_json }

      it "adds a new coupon" do
        expect do
          post url, headers: auth_header(user), params: coupon_params
        end.to change(Coupon, :count).by(1)
      end

      it "returns last added coupon" do
        post url, headers: auth_header(user), params: coupon_params
        coupon_attributes = %i(id name code status discount_value max_use due_date)
        expected_coupon = Coupon.last.as_json(only: coupon_attributes)
        expect(body_json["coupon"]).to eq expected_coupon
      end

      it "returns success status" do
        post url, headers: auth_header(user), params: coupon_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:coupon_invalid) do
        { coupon: attributes_for(:coupon, code: nil) }.to_json
      end

      it "does not a new coupon" do
        expect do
          post url, headers: auth_header(user), params: coupon_invalid
        end.to_not change(Coupon, :count)
      end

      it "returns error message" do
        post url, headers: auth_header(user), params: coupon_invalid
        expect(body_json["errors"]["fields"]).to have_key("code")
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(user), params: coupon_invalid
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
