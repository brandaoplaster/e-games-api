# frozen_string_literal: true

class Game < ApplicationRecord
  include LikeSearchable
  include Paginatable

  belongs_to :system_requirement
  has_one :product, as: :productable
  has_many :licenses

  validates :mode, :release_date, :developer, presence: true

  enum mode: { pvp: 1, pve: 2, both: 3 }

  def ship!(line_item)
    Admin::AllocateLicenseJob.perform_later(line_item)
  end
end
