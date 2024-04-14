require "rails_helper"

describe "User see product models" do
  it "from menu" do
    #arrange

    #act
    visit root_path
    within("nav") do
      click_on "Product models"
    end
    #assert
    expect(current_path).to eq product_models_path
  end

  it "with success" do
    #arrange
    supplier = Supplier.create!(corporate_name: "IBM", brand_name: "Lenovo",
    registration_number: "112345", adress: "Pen street 40", city: "San Jose",
    state: "CA", email: "lenovo@ibm.com")

    ProductModel.create!(name: "Lenovo a3 Notebook", weight: 2000, width: 65, height:35,
    depth: 6, sku: "#ssdhtjlk1213457", supplier: supplier)

    ProductModel.create!(name: "Lenovo f5 Smartphone", weight: 400, width: 30, height:17,
    depth: 2, sku: "#ffhjy667456", supplier: supplier)
    #act
    visit root_path
    within("nav") do
      click_on "Product models"
    end
    #assert
    expect(page).to have_content "Lenovo a3 Notebook"
    expect(page).to have_content "#ssdhtjlk1213457"
    expect(page).to have_content "Lenovo"
    expect(page).to have_content "Lenovo f5 Smartphone"
    expect(page).to have_content "#ffhjy667456"
    expect(page).to have_content "Lenovo"
  end
end
