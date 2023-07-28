require "rails_helper"

RSpec.describe "Admin::V1::SystemRequirements", type: :request do
  context "GET /system_requirements" do
    let(:url) { "/admin/v1/system_requirements" }
    let!(:system_requirements) { create_list(:system_requirement, 5) }

    before(:each) { get url }

    include_examples "unauthenticated access"
  end
end
