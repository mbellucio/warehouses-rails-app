require "rails_helper"

describe "User acess home page and" do
  it "sees app name" do
    #arrange

    #act
    visit("/")

    #assert
    expect(page).to have_content("Warehouses & Inventory")
  end

  it "sees all registered warehouses" do
    #arrange
    Warehouse.create(name: "Rio", code: "SDU", city: "Rio de Janeiro",
    area: 60_000, adress: "Test 1000", zip: "1000-00", description: "test")
    Warehouse.create(name: "Maceio", code: "MCZ", city: "Maceio",
    area: 50_000, adress: "Test 1000", zip: "1000-00", description: "test")

    #act
    visit("/")

    #assert
    expect(page).not_to have_content("There are no registered warehouses")
    expect(page).to have_content("Rio")
    expect(page).to have_content("Código: SDU")
    expect(page).to have_content("Cidade: Rio de Janeiro")
    expect(page).to have_content("60000 m2")

    expect(page).to have_content("Maceio")
    expect(page).to have_content("Código: MCZ")
    expect(page).to have_content("Cidade: Maceio")
    expect(page).to have_content("50000 m2")
  end

  it "there is no registered warehouses" do
    #arrange

    #act
    visit("/")
    #assert
    expect(page).to have_content("There are no registered warehouses")
  end
end
