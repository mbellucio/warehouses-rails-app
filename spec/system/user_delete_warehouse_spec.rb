require "rails_helper"

describe "User removes a Warehouse" do
  it "with sucess" do
    #arrange
    Warehouse.create!(name: "Maceio", code: "MCZ", city: "Maceio",
    area: 50_000, adress: "Test 1000", zip: "1000-00", description: "test")
    #act
    visit root_path
    click_on "Maceio"
    click_on "Delete"
    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content("Warehouse sucessfully removed!")
    expect(page).not_to have_content("Maceio")
  end

  it "do not delete other Warehouses" do
    #arrange
    Warehouse.create!(name: "Maceio", code: "MCZ", city: "Maceio",
    area: 50_000, adress: "Test 1000", zip: "1000-00", description: "test")
    Warehouse.create!(name: "Rio", code: "SDU", city: "Rio de Janeiro",
    area: 70_000, adress: "Test 1234", zip: "1100-23", description: "test2")
    #act
    visit root_path
    click_on "Maceio"
    click_on "Delete"
    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content("Warehouse sucessfully removed!")
    expect(page).to have_content("Rio")
    expect(page).to have_content("SDU")
    expect(page).not_to have_content("Maceio")
    expect(page).not_to have_content("MCZ")
  end
end
