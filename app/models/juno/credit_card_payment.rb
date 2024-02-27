# frozen_string_literal: true

class Juno::CreditCardPayment < ApplicationRecord
  belongs_to :charge

  validates :key, :status, :release_date, presence: true
end
