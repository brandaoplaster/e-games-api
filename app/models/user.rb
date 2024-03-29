# frozen_string_literal: true

class User < ActiveRecord::Base
  include Paginatable
  include LikeSearchable

  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :wish_items, dependent: :destroy
  has_many :orders

  validates :name, :profile, presence: true
  enum profile: { admin: 1, client: 0 }
end
