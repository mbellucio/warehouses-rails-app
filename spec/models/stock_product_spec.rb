require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  context "#valid?" do
    describe "random code" do
      it "generate random code upon creation" do
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
        user: user, arrival_date: 1.week.from_now, status: :delivered)
        product = ProductModel.create!(name: "Lenovo Notebook", weight: 2000, width: 65, height:35,
        depth: 6, sku: "#ssdhtjlk1213457", supplier: supplier)
        #act
        stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
        #assert
        expect(stock_product.serial_number.length).to eq 20
      end

      it "and never changes" do
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
        user: user, arrival_date: 1.week.from_now, status: :delivered)
        product = ProductModel.create!(name: "Lenovo Notebook", weight: 2000, width: 65, height:35,
        depth: 6, sku: "#ssdhtjlk1213457", supplier: supplier)
        product_2 = ProductModel.create!(name: "Dell Notebook", weight: 2000, width: 65, height:35,
        depth: 6, sku: "#ssdhtjlk1qweqwe", supplier: supplier)
        #act
        stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
        original_serial_number = stock_product.serial_number
        #act
        stock_product.update(product_model: product_2)
        #assert
        expect(stock_product.serial_number).to eq original_serial_number
      end
    end
  end

end
