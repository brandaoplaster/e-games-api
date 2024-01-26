# frozen_string_literal: true

class License < ApplicationRecord
  belongs_to :game

  validates :key, :status, :platform, presence: true
  validates :key, uniqueness: { case_sensitive: false, scope: :platform }

  enum platform: { steam: 1, battle_net: 2, origin: 3 }
  enum status: { available: 1, in_use: 2, unavailable: 3 }
end
