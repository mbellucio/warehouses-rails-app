require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe "#valid?" do
    context "presence" do
      it "false when name is empty" do
        #arrange
        warehouse = Warehouse.new(name: "", code: "RIO", adress: "adressTest",
        description: "something", city: "Rio de Janeiro", zip: "11220-00",
        area: 60000)
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq(false)
      end

      it "false when code is empty" do
        #arrange
        warehouse = Warehouse.new(name: "Rio", code: "", adress: "adressTest",
        description: "something", city: "Rio de Janeiro", zip: "11220-00",
        area: 60000)
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq(false)
      end

      it "false when adress is empty" do
        #arrange
        warehouse = Warehouse.new(name: "Rio", code: "RIO", adress: "",
        description: "something", city: "Rio de Janeiro", zip: "11220-00",
        area: 60000)
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq(false)
      end

      it "false when description is empty" do
        #arrange
        warehouse = Warehouse.new(name: "Rio", code: "RIO", adress: "test",
        description: "", city: "Rio de Janeiro", zip: "11220-00",
        area: 60000)
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq(false)
      end

      it "false when city is empty" do
        #arrange
        warehouse = Warehouse.new(name: "Rio", code: "RIO", adress: "test",
        description: "test", city: "", zip: "11220-00",
        area: 60000)
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq(false)
      end

      it "false when zip is empty" do
        #arrange
        warehouse = Warehouse.new(name: "Rio", code: "RIO", adress: "test",
        description: "test", city: "Rio de Janeiro", zip: "",
        area: 60000)
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq(false)
      end

      it "false when area is empty" do
        #arrange
        warehouse = Warehouse.new(name: "Rio", code: "RIO", adress: "test",
        description: "test", city: "Rio de Janeiro", zip: "11478-00",
        area: "")
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq(false)
      end
    end

    context "uniqueness" do
      it "false when code already exists" do
        #arrange
        warehouse1 = Warehouse.create(name: "Rio", code: "RIO", adress: "adressTest",
        description: "something", city: "Rio de Janeiro", zip: "11220-00",
        area: 60000)
        warehouse2 = Warehouse.new(name: "Sao paulo", code: "RIO", adress: "adressTest2",
        description: "something2", city: "Sao Paulo", zip: "33420-22",
        area: 60000)
        #act
        # result = warehouse2.valid?
        # #assert
        # expect(result).to eq(false)
        expect(warehouse2).not_to be_valid
      end
    end
  end
end
