require "rails_helper"

RSpec.describe "Admin::V1::Products", type: :request do
  let(:user) { create(:user) }

  context "GET /products" do
    let(:url) { "/admin/v1/products" }
    let!(:categories) { create_list(:category, 2) }
    let!(:products) { create_list(:product, 1, categories: categories) }

    context "without any params" do
      it "returns 10 records" do
        get url, headers: auth_header(user)
        expect(body_json["products"].count).to eq 1
      end

      it "returns Products with :productable following default pagination" do
        get url, headers: auth_header(user)
        expected_return = products[0..9].map do |product|
          build_game_product_json(product)
        end
        expect(body_json["products"]).to contain_exactly *expected_return
      end

      it "returns success status" do
        get url, headers: auth_header(user)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

def build_game_product_json(product)
  json = product.as_json(only: %i(id name description price status))
  json["categories"] = product.categories.map(&:name)
  json["image_url"] = rails_blob_url(product.image)
  json["productable"] = product.productable_type.underscore
  json.merge! product.productable.as_json(only: %i(mode release_date developer))
end
