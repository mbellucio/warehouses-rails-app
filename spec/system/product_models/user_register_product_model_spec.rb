require "rails_helper"

describe "User register a product model" do
  it "with success" do
    #arrange
    user = User.create!(email: "admin@gmail.com", password: "flamengo2019")

    supplier = Supplier.create!(corporate_name: "IBM", brand_name: "Lenovo",
    registration_number: "112345", adress: "Pen street 40", city: "San Jose",
    state: "CA", email: "lenovo@ibm.com")

    supplier2 = Supplier.create!(corporate_name: "Samsumg Corps", brand_name: "Samsumg",
    registration_number: "5567845", adress: "Pen street 20", city: "San Jose",
    state: "CA", email: "samsumg@ibm.com")
    #act
    login_as(user, :scope => :user)
    visit root_path
    click_on "Product models"
    click_on "Register Product model"
    fill_in "Name",	with: "Lenovo SmartPad"
    fill_in "Weight",	with: "500"
    fill_in "Width",	with: "20"
    fill_in "Height",	with: "45"
    fill_in "Depth",	with: "2"
    fill_in "Sku",	with: "#ffghy6768"
    select "Samsumg", from: "Supplier"
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

  it "and must fill all fields" do
    #arrange
    user = User.create!(email: "admin@gmail.com", password: "flamengo2019")

    supplier = Supplier.create!(corporate_name: "IBM", brand_name: "Lenovo",
    registration_number: "112345", adress: "Pen street 40", city: "San Jose",
    state: "CA", email: "lenovo@ibm.com")

    #act
    login_as(user, :scope => :user)
    visit root_path
    click_on "Product models"
    click_on "Register Product model"
    fill_in "Name",	with: ""
    fill_in "Weight",	with: "500"
    fill_in "Width",	with: "20"
    fill_in "Height",	with: "45"
    fill_in "Depth",	with: "2"
    fill_in "Sku",	with: ""
    click_on "Save"

    #assert
    expect(page).to have_content "Unable to register product model"
  end
end
