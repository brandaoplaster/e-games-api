require "rails_helper"

RSpec.describe LineItem, type: :model do
  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_presence_of(:payed_price) }
  it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:payed_price).is_greater_than(0) }
  it { is_expected.to validate_presence_of(:status).on(:update) }
  it { is_expected.to define_enum_for(:status).with_values(waiting_order: 1, preparing: 2, en_route: 3, delivered: 4) }

  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:product) }

  it "receives :waiting_order status as default on creating" do
    subject = build(:line_item, status: nil)
    expect(subject.status).to eq "waiting_order"
  end

  it "#total must return the multiplication of :payed_price by :quantity" do
    payed_price = 153.32
    quantity = 2
    subject = build(:line_item, payed_price: payed_price, quantity: quantity)
    expect_value = payed_price * quantity
    expect(subject.total).to eq expect_value
  end
end
