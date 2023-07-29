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

  describe "POST /system_requirements" do
    let(:url) { "/admin/v1/system_requirements" }

    context "with valid params" do
      let(:system_requirement_params) do
        { system_requirement: attributes_for(:system_requirement) }.to_json
      end

      it "adds a new system requirement" do
        expect do
          post url, headers: auth_header(user), params: system_requirement_params
        end.to change(SystemRequirement, :count).by(1)
      end

      it "returns last added system requirement" do
        post url, headers: auth_header(user), params: system_requirement_params

        sr_attributes = %i(id name operational_system storage processor memory video_board)

        expected_system_requirement = SystemRequirement.last.as_json(only: sr_attributes)
        expect(body_json["system_requirement"]).to eq expected_system_requirement
      end

      it "returns success status" do
        post url, headers: auth_header(user), params: system_requirement_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:system_requirement_invalid) do
        { system_requirement: attributes_for(:system_requirement, name: nil) }.to_json
      end

      it "does not a new system requirement" do
        expect do
          post url, headers: auth_header(user), params: system_requirement_invalid
        end.to_not change(SystemRequirement, :count)
      end

      it "returns error message" do
        post url, headers: auth_header(user), params: system_requirement_invalid
        expect(body_json["errors"]["fields"]).to have_key("name")
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(user), params: system_requirement_invalid
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
