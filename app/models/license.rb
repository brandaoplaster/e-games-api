# frozen_string_literal: true

class License < ApplicationRecord
  include Paginatable
  include LikeSearchable

  belongs_to :game
  belongs_to :line_item, optional: true

  validates :key, :status, :platform, presence: true
  validates :key, uniqueness: { case_sensitive: false, scope: :platform }
  validates :line_item, presence: true, if: -> { self.status == "in_use" }

  enum platform: { steam: 1, battle_net: 2, origin: 3 }
  enum status: { available: 1, in_use: 2, unavailable: 3 }
end
