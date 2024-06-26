require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:profile) }
  it { is_expected.to define_enum_for(:profile).with_values({ admin: 1, client: 0 }) }
  it { is_expected.to have_many(:wish_items).dependent(:destroy) }
  it { is_expected.to have_many :orders }

  it_has_behavior_of "like searchable concern", :user, :name
  it_behaves_like "paginatable concern", :user
end
