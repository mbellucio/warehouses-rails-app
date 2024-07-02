require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#valid?" do
    it "false if there is no code" do
      #arrange
      supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
      registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
      state: "RJ", email: "flamengo@gmail.com")

      warehouse = Warehouse.create!(
      name: "São Paulo",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      adress: "Avenida do Aeroporto, 1000",
      zip: "15000-000",
      description: "Warehouse for international cargo usage"
      )

      user = User.create!(name: "Matheus", email: "admin@gmail.com", password: "flamengo2019")
      order = Order.new(warehouse: warehouse, supplier: supplier,
      user: user, arrival_date: "2024-07-12")

      #act
      result = order.valid?
      #assert
      expect(result).to be_truthy
    end

    it "estimated time of arrival must be mandatory" do
      #arrange
      order = Order.new(arrival_date: "")
      #act
      order.valid?
      #assert
      expect(order.errors.include? :arrival_date).to be_truthy
    end

    it "estimated time of arrival must be in the future" do
      #arrange
      order = Order.new(arrival_date: 1.day.ago)
      #act
      order.valid?
      #assert
      expect(order.errors.include? :arrival_date).to be_truthy
      expect(order.errors[:arrival_date]).to include(" deve ser futura.")
    end

    it "estimated time of arrival cannot be today" do
      #arrange
      order = Order.new(arrival_date: Date.today)
      #act
      order.valid?
      #assert
      expect(order.errors.include? :arrival_date).to be_truthy
      expect(order.errors[:arrival_date]).to include(" deve ser futura.")
    end

    it "estimated time of arrival must be greater or equal to tomorrow" do
      #arrange
      order = Order.new(arrival_date: 1.day.from_now)
      #act
      order.valid?
      #assert
      expect(order.errors.include? :arrival_date).to be_falsy
      expect(order.errors[:arrival_date]).not_to include(" deve ser futura.")
    end
  end

  describe "Generate random code" do
    it "when creating a new order" do
      #arrange
      supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
      registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
      state: "RJ", email: "flamengo@gmail.com")

      warehouse = Warehouse.create!(
      name: "São Paulo",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      adress: "Avenida do Aeroporto, 1000",
      zip: "15000-000",
      description: "Warehouse for international cargo usage"
      )

      user = User.create!(name: "Matheus", email: "admin@gmail.com", password: "flamengo2019")
      order = Order.new(warehouse: warehouse, supplier: supplier,
      user: user, arrival_date: "2024-07-12")
      #act
      order.save!
      result = order.code
      #assert
      expect(result).not_to be_empty
      expect(result.length).to eq(10)
    end

    it "is unique" do
      #arrange
      supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
      registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
      state: "RJ", email: "flamengo@gmail.com")

      warehouse = Warehouse.create!(
      name: "São Paulo",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      adress: "Avenida do Aeroporto, 1000",
      zip: "15000-000",
      description: "Warehouse for international cargo usage"
      )

      user = User.create!(name: "Matheus", email: "admin@gmail.com", password: "flamengo2019")
      order_a = Order.new(warehouse: warehouse, supplier: supplier,
      user: user, arrival_date: "2024-07-12")
      order_b = Order.new(warehouse: warehouse, supplier: supplier,
      user: user, arrival_date: "2024-07-26")
      #act
      order_a.save!
      order_b.save!
      #assert
      expect(order_a.code).not_to eq(order_b.code)
     end

     it "should not be modified" do
      #arrange
      supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
      registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
      state: "RJ", email: "flamengo@gmail.com")

      warehouse = Warehouse.create!(
      name: "São Paulo",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      adress: "Avenida do Aeroporto, 1000",
      zip: "15000-000",
      description: "Warehouse for international cargo usage"
      )

      user = User.create!(name: "Matheus", email: "admin@gmail.com", password: "flamengo2019")
      order = Order.create!(warehouse: warehouse, supplier: supplier,
      user: user, arrival_date: 1.week.from_now)
      original_code = order.code
      #act
      order.update(arrival_date: 1.day.from_now)
      #assert
      expect(order.code).to eq original_code
     end
  end
end
