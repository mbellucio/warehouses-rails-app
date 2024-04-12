class Warehouse < ApplicationRecord
  validates :name, :code, :description, :adress,
  :city, :zip, :area,  presence: true

  validates(:code, length:{is:3})
  validates :code, uniqueness: true
end
