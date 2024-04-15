require "rails_helper"

describe "User register a product model" do
  it "with success" do
    #arrange
    supplier = Supplier.create!(corporate_name: "IBM", brand_name: "Lenovo",
    registration_number: "112345", adress: "Pen street 40", city: "San Jose",
    state: "CA", email: "lenovo@ibm.com")
    #act
    visit root_path
    click_on "Product models"
    click_on "Register Product model"
    fill_in "Name",	with: "Lenovo SmartPad"
    fill_in "Weight",	with: "500"
    fill_in "Width",	with: "20"
    fill_in "Height",	with: "45"
    fill_in "Depth",	with: "2"
    fill_in "Sku",	with: "#ffghy6768"
    select "Lenovo", from: "Supplier"
    click_on "Save"
    #assert
    expect(page).to have_content "Product model successfully registered!"
    expect(page).to have_content "Lenovo SmartPad"
    expect(page).to have_content "Supplier: Lenovo"
    expect(page).to have_content "Sku: #ffghy6768"
    expect(page).to have_content "Dimensions: 20cm x 45cm x 2cm"
    expect(page).to have_content "Weight: 500g"
  end
end
