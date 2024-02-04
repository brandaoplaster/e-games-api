# frozen_string_literal: true

class Coupon < ApplicationRecord
  class InvalidUse < StandardError; end

  include LikeSearchable
  include Paginatable

  validates :name, :due_date, :status, presence: true
  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :discount_value, presence: true, numericality: { greater_than: 0 }
  validates :max_use, presence: true, numericality: { greater_than: 0 }
  validates :due_date, presence: true, future_date: true

  enum status: { active: 1, inactive: 0 }

  def validate_use!
    raise InvalidUse unless self.active? &&  self.due_date >= Time.zone.now
    true
  end
end
