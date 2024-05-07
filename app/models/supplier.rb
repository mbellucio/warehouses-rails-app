class Supplier < ApplicationRecord
  has_many :product_models

  validates :corporate_name, :brand_name, :registration_number,
  :adress, :city, :state, :email, presence: true

  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}
  validates :state, length: {is:2}
  validates :registration_number, uniqueness: true
end
