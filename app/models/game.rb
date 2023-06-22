# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :system_requirement

  validates :mode, :release_date, :developer, presence: true

  enum mode: { pvp: 1, pve: 2, both: 3 }
end
