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
end
