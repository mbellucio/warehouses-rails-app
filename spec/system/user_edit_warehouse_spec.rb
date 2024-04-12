require "rails_helper"

describe "User edits a Warehouse" do
  it "from a details page" do
    #arrange
    Warehouse.create!(name: "Maceio", code: "MCZ", city: "Maceio",
    area: 50_000, adress: "Test 1000", zip: "1000-00", description: "test")
    #act
    visit root_path
    click_on "Maceio"
    click_on "Edit"
    #assert
    expect(page).to have_content "Edit Warehouse"
    expect(page).to have_field("Name", with: "Maceio")
    expect(page).to have_field("Description", with: "test")
    expect(page).to have_field("Code", with: "MCZ")
    expect(page).to have_field("Adress", with: "Test 1000")
    expect(page).to have_field("City", with: "Maceio")
    expect(page).to have_field("Zip", with: "1000-00")
    expect(page).to have_field("Area", with: 50000)
  end

  it "sucessfully" do
    #arrange
    Warehouse.create!(name: "Maceio", code: "MCZ", city: "Maceio",
    area: 50_000, adress: "Test 1000", zip: "1000-00", description: "test")
    #act
    visit root_path
    click_on "Maceio"
    click_on "Edit"
    fill_in "Name", with: "Rio de Janeiro"
    fill_in "Code", with: "SDU"
    fill_in "Zip", with: "1000-09"
    click_on "Save"
    #assert
    expect(page).to have_content "Warehouse sucessfully edited!"
    expect(page).to have_content "Rio de Janeiro"
    expect(page).to have_content "SDU"
    expect(page).to have_content "zip: 1000-09"
  end

  it "with incomplete data" do
    #arrange
    Warehouse.create!(name: "Maceio", code: "MCZ", city: "Maceio",
    area: 50_000, adress: "Test 1000", zip: "1000-00", description: "test")
    #act
    visit root_path
    click_on "Maceio"
    click_on "Edit"
    fill_in "Name", with: ""
    fill_in "Code", with: ""
    fill_in "Zip", with: ""
    click_on "Save"
    #assert
    expect(page).to have_content "Warehouse not edited."
  end
end
