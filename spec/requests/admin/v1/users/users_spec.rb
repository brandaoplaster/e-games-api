require "rails_helper"

RSpec.describe "Admin::V1::Users", type: :request do
  let!(:login_user) { create(:user) }

  context "GET /users" do
    let(:url) { "/admin/v1/users" }
    let!(:users) { create_list(:user, 10) }

    it "returns 10 users" do
      get url, headers: auth_header(login_user)
      expect(body_json["users"].count).to eq 10
    end

    it "returns 10 first Users" do
      get url, headers: auth_header(login_user)
      user_attributes = %i(id name email profile)
      expected_users = users[0..9].as_json(only: user_attributes)
      expect(body_json["users"]).to contain_exactly *expected_users
    end

    it "returns success status" do
      get url, headers: auth_header(login_user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /users" do
    let(:url) { "/admin/v1/users" }

    context "with valid params" do
      let(:user_params) { { user: attributes_for(:user) }.to_json }

      it "adds a new user" do
        expect do
          post url, headers: auth_header(login_user), params: user_params
        end.to change(User, :count).by(1)
      end

      it "returns last added user" do
        post url, headers: auth_header(login_user), params: user_params
        expected_user = User.last.as_json(only: %i(id name email profile))
        expect(body_json["user"]).to eq expected_user
      end

      it "returns success status" do
        post url, headers: auth_header(login_user), params: user_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:user_invalid_params) do
        { user: attributes_for(:user, name: nil) }.to_json
      end

      it "does not add a new user" do
        expect do
          post url, headers: auth_header(login_user), params: user_invalid_params
        end.to_not change(User, :count)
      end

      it "returns error message" do
        post url, headers: auth_header(login_user), params: user_invalid_params
        expect(body_json["errors"]["fields"]).to have_key("name")
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(login_user), params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
