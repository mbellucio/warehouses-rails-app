require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe "#valid?" do
    context "presence" do
      it "false when corporate name is empty" do
        #arrange
        supplier = Supplier.new(corporate_name: "", brand_name: "CRF",
        registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
        state: "RJ", email: "flamengo@gmail.com")
        #act
        #assert
        expect(supplier).not_to be_valid
      end

      it "false when brand name is empty" do
        #arrange
        supplier = Supplier.new(corporate_name: "Flamengo", brand_name: "",
        registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
        state: "RJ", email: "flamengo@gmail.com")
        #act
        #assert
        expect(supplier).not_to be_valid
      end

      it "false when registration number is empty" do
        #arrange
        supplier = Supplier.new(corporate_name: "Flamengo", brand_name: "CRF",
        registration_number: "", adress: "Gávea 40", city: "Rio de Janeiro",
        state: "RJ", email: "flamengo@gmail.com")
        #act
        #assert
        expect(supplier).not_to be_valid
      end

      it "false when adress is empty" do
        #arrange
        supplier = Supplier.new(corporate_name: "Flamengo", brand_name: "CRF",
        registration_number: "112345", adress: "", city: "Rio de Janeiro",
        state: "RJ", email: "flamengo@gmail.com")
        #act
        #assert
        expect(supplier).not_to be_valid
      end

      it "false when city is empty" do
        #arrange
        supplier = Supplier.new(corporate_name: "Flamengo", brand_name: "CRF",
        registration_number: "112345", adress: "Gávea 40", city: "",
        state: "RJ", email: "flamengo@gmail.com")
        #act
        #assert
        expect(supplier).not_to be_valid
      end

      it "false when state is empty" do
        #arrange
        supplier = Supplier.new(corporate_name: "Flamengo", brand_name: "CRF",
        registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
        state: "", email: "flamengo@gmail.com")
        #act
        #assert
        expect(supplier).not_to be_valid
      end

      it "false when email is empty" do
        #arrange
        supplier = Supplier.new(corporate_name: "Flamengo", brand_name: "CRF",
        registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
        state: "RJ", email: "")
        #act
        #assert
        expect(supplier).not_to be_valid
      end
    end

    context "uniqueness" do
      it "false when registration number already exists" do
        #arrange
        supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
        registration_number: "404020561", adress: "Gávea 40", city: "Rio de Janeiro",
        state: "RJ", email: "flamengo@gmail.com")
        supplier2 = Supplier.new(corporate_name: "Vasco", brand_name: "CRVG",
        registration_number: "404020561", adress: "Barreira do Vasco", city: "Rio de Janeiro",
        state: "RJ", email: "vasco@gmail.com")
        #act
        #assert
        expect(supplier2).not_to be_valid
      end
    end

    context "length" do
      it "false when state lengh not equal to 2" do
        #arrange
        supplier = Supplier.new(corporate_name: "Vasco", brand_name: "CRVG",
        registration_number: "404020561", adress: "Barreira do Vasco", city: "Rio de Janeiro",
        state: "RJJ", email: "vasco@gmail.com")
        supplier2 = Supplier.new(corporate_name: "Flamengo", brand_name: "CRF",
        registration_number: "41234679", adress: "Gávea 40", city: "Rio de Janeiro",
        state: "R", email: "flamengo@gmail.com")
        #act
        #assert
        expect(supplier).not_to be_valid
        expect(supplier2).not_to be_valid
      end
    end

    context "format" do
      it "false when email has invalid format" do
        #arrange
        supplier = Supplier.new(corporate_name: "Vasco", brand_name: "CRVG",
        registration_number: "404020561", adress: "Barreira do Vasco", city: "Rio de Janeiro",
        state: "RJ", email: "vascogmailcom")
        #act
        #assert
        expect(supplier).not_to be_valid
      end
    end

  end
end
