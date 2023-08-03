require "rails_helper"

RSpec.describe "Admin v1 users without authentication", type: :request do
  context "GET /user" do
    let(:url) { "/admin/v1/users" }
    let!(:users) { create_list(:user, 5) }

    before(:each) { get url }
  end
end