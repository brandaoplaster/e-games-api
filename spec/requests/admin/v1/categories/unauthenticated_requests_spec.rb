require "rails_helper"

RSpec.describe "Admin v1 categories without authentication", type: :request do
  context "GET /catgories" do
    let(:url) { "/admin/v1/categories" }
    let!(:categories) { create_list(:category, 5) }

    before(:each) { get url }
  end

  context "POST /categories" do
    let(:url) { "/admin/v1/categories" }

    before(:each) { post url }

    include_examples "unauthenticated access"
  end

  context "PATCH /categories/:id" do
    let(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }

    before(:each) { patch url }

    include_examples "unauthenticated access"
  end

  context "GET /categories/:id" do
    let!(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }

    before(:each) { get url }

    include_examples "unauthenticated access"
  end

  context "DELTE /categories" do
    let!(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }

    before(:each) { delete url }

    include_examples "unauthenticated access"
  end
end
