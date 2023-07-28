require "rails_helper"

RSpec.describe "Admin::V1::SystemRequirements", type: :request do
  let(:user) { create(:user) }

  describe "GET /system_requirements" do
    let(:url) { "/admin/v1/system_requirements" }
    let!(:system_requirements) { create_list(:system_requirement, 5) }

    it "returns all system requirements" do
      get url, headers: auth_header(user)
      system_requirement_params = %i(id name operational_system storage processor memory video_board)
      expect(body_json["system_requirements"]).to contain_exactly *system_requirements.as_json(only: system_requirement_params)
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end
end
