class Warehouse < ApplicationRecord
  has_many :stock_products

  validates :name, :code, :description, :adress,
  :city, :zip, :area,  presence: true

  validates :code, length:{is:3}
  validates :code, uniqueness: true

  def full_description
    "#{code} | #{name}"
  end
end
