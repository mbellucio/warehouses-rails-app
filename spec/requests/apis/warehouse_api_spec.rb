require 'rails_helper'

describe 'Warehouse API' do
  context "GET /api/v1/warehouses/1" do
    it 'success' do
      #arrange
      warehouse = Warehouse.create(
        name: "São Paulo",
        code: "GRU",
        city: "Guarulhos",
        area: 100_000,
        adress: "Avenida do Aeroporto, 1000",
        zip: "15000-000",
        description: "Warehouse for international cargo usage"
      )
      #act
      get "/api/v1/warehouses/#{warehouse.id}"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"

      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq "São Paulo"
      expect(json_response["code"]).to eq "GRU"
      expect(json_response["zip"]).to eq "15000-000"
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
    end

    it "fails if warehouse not found" do
      #arrange

      #act
      get "/api/v1/warehouses/9999999"
      #assert
      expect(response.status).to eq 404
    end
  end

  context "GET /api/v1/warehouses" do
    it "success" do
      #arrange
      warehouse = Warehouse.create(
        name: "São Paulo",
        code: "GRU",
        city: "Guarulhos",
        area: 100_000,
        adress: "Avenida do Aeroporto, 1000",
        zip: "15000-000",
        description: "Warehouse for international cargo usage"
      )
      warehouse_2 = Warehouse.create(
        name: "Rio de Janeiro",
        code: "SDU",
        city: "Rio de Janeiro",
        area: 150_000,
        adress: "Avenida das Américas 40",
        zip: "15455-867",
        description: "Warehouse for international cargo usage"
      )
      #act
      get "/api/v1/warehouses"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2

      expect(json_response.first["name"]).to eq "São Paulo"
      expect(json_response.first["code"]).to eq "GRU"
      expect(json_response.last["name"]).to eq "Rio de Janeiro"
      expect(json_response.last["code"]).to eq "SDU"
    end

    it "return empty if there is no warehouse" do
      #arrange

      #act
      get "/api/v1/warehouses"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end

  context "POST /api/v1/warehouses" do
    it "success" do
      #arrange
      warehouse_params = { warehouse: {
        name: "São Paulo",
        code: "GRU",
        city: "Guarulhos",
        area: 100_000,
        adress: "Avenida do Aeroporto, 1000",
        zip: "15000-000",
        description: "Warehouse for international cargo usage"
      }}
      #act
      post "/api/v1/warehouses", params: warehouse_params
      #assert
      expect(response.status).to eq 201
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq "São Paulo"
      expect(json_response["code"]).to eq "GRU"
      expect(json_response["city"]).to eq "Guarulhos"
      expect(json_response["area"]).to eq 100000
      expect(json_response["adress"]).to eq "Avenida do Aeroporto, 1000"
      expect(json_response["zip"]).to eq "15000-000"
      expect(json_response["description"]).to eq "Warehouse for international cargo usage"
    end

    it "fails if parameters are not complete" do
      #arrange
      warehouse_params = { warehouse: {
        name: "São Paulo",
        code: "GRU",
      }}
      #act
      post "/api/v1/warehouses", params: warehouse_params
      #assert
      expect(response.status).to eq 412
      json_response = JSON.parse(response.body)

      expect(json_response["errors"]).to include "Description can't be blank"
      expect(json_response["errors"]).to include "Adress can't be blank"
      expect(json_response["errors"]).to include "City can't be blank"
      expect(json_response["errors"]).to include "Zip can't be blank"
      expect(json_response["errors"]).to include "Area can't be blank"
    end

    it "fails if internal errror" do

    end
  end
end
