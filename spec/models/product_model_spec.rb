require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  context "presence" do
    describe "#valid?" do
      it "false when name is empty" do
        #arrange
        supplier = Supplier.create!(corporate_name: "IBM", brand_name: "Lenovo",
        registration_number: "112345", adress: "Pen street 40", city: "San Jose",
        state: "CA", email: "lenovo@ibm.com")

        pm = ProductModel.new(name: "", weight: 2000, width: 65, height:35,
        depth: 6, sku: "#ssdhtjlk1213457", supplier: supplier)
        #act
        #assert
        expect(pm).not_to be_valid
      end

      it "false when sku is empty" do
        #arrange
        supplier = Supplier.create!(corporate_name: "IBM", brand_name: "Lenovo",
        registration_number: "112345", adress: "Pen street 40", city: "San Jose",
        state: "CA", email: "lenovo@ibm.com")

        pm = ProductModel.new(name: "Lenovo notebook", weight: 2000, width: 65, height:35,
        depth: 6, sku: "", supplier: supplier)
        #act
        #assert
        expect(pm).not_to be_valid
      end
    end
  end
end
