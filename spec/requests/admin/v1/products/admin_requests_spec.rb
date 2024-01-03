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

  context "POST /products" do
    let(:url) { "/admin/v1/products" }
    let(:categories) { create_list(:category, 2) }
    let(:system_requirement) { create(:system_requirement) }
    let(:post_header) { auth_header(user, merge_with: { "Content-Type" => "multipart/form-data" }) }

    context "with valid params" do
      let(:game_params) { attributes_for(:game, system_requirement_id: system_requirement.id) }
      let(:product_params) do
        { product: attributes_for(:product).merge(category_ids: categories.map(&:id))
          .merge(productable: "game").merge(game_params) }
      end

      it "adds a new Product" do
        expect do
          post url, headers: post_header, params: product_params
        end.to change(Product, :count).by(1)
      end

      it "adds a new productable" do
        expect do
          post url, headers: post_header, params: product_params
        end.to change(Game, :count).by(1)
      end

      it "associates categories to Product" do
        post url, headers: post_header, params: product_params
        expect(Product.last.categories.ids).to contain_exactly *categories.map(&:id)
      end

      it "returns last added Product" do
        post url, headers: post_header, params: product_params
        expected_product = build_game_product_json(Product.last)
        expect(body_json["product"]).to eq expected_product
      end

      it "returns success status" do
        post url, headers: post_header, params: product_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid Product params" do
      let(:game_params) { attributes_for(:game, system_requirement_id: system_requirement.id) }
      let(:product_invalid_params) do
        { product: attributes_for(:product, name: nil).merge(category_ids: categories.map(&:id))
          .merge(productable: "game").merge(game_params) }
      end

      it "does not add a new Product" do
        expect do
          post url, headers: post_header, params: product_invalid_params
        end.to_not change(Product, :count)
      end

      it "does not add a new productable" do
        expect do
          post url, headers: post_header, params: product_invalid_params
        end.to_not change(Game, :count)
      end

      it "does not create ProductCategory" do
        expect do
          post url, headers: post_header, params: product_invalid_params
        end.to_not change(ProductCategory, :count)
      end

      it "returns error message" do
        post url, headers: post_header, params: product_invalid_params
        expect(body_json["errors"]["fields"]).to have_key("name")
      end

      it "returns unprocessable_entity status" do
        post url, headers: post_header, params: product_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid productable params" do
      let(:game_params) { attributes_for(:game, developer: "", system_requirement_id: system_requirement.id) }
      let(:invalid_productable_params) do
        { product: attributes_for(:product).merge(productable: "game").merge(game_params) }
      end

      it "does not add a new Product" do
        expect do
          post url, headers: post_header, params: invalid_productable_params
        end.to_not change(Product, :count)
      end

      it "does not add a new productable" do
        expect do
          post url, headers: post_header, params: invalid_productable_params
        end.to_not change(Game, :count)
      end

      it "does not create ProductCategory" do
        expect do
          post url, headers: post_header, params: invalid_productable_params
        end.to_not change(ProductCategory, :count)
      end

      it "returns error message" do
        post url, headers: post_header, params: invalid_productable_params
        expect(body_json["errors"]["fields"]).to have_key("developer")
      end

      it "returns unprocessable_entity status" do
        post url, headers: post_header, params: invalid_productable_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "without productable params" do
      let(:product_without_productable_params) do
        { product: attributes_for(:product).merge(categories_ids: categories.map(&:id)) }
      end

      it "does not add a new Product" do
        expect do
          post url, headers: post_header, params: product_without_productable_params
        end.to_not change(Product, :count)
      end

      it "does not add a new productable" do
        expect do
          post url, headers: post_header, params: product_without_productable_params
        end.to_not change(Game, :count)
      end

      it "does not create ProductCategory" do
        expect do
          post url, headers: post_header, params: product_without_productable_params
        end.to_not change(ProductCategory, :count)
      end

      it "returns error message" do
        post url, headers: post_header, params: product_without_productable_params
        expect(body_json["errors"]["fields"]).to have_key("productable")
      end

      it "returns unprocessable_entity status" do
        post url, headers: post_header, params: product_without_productable_params
        expect(response).to have_http_status(:unprocessable_entity)
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
