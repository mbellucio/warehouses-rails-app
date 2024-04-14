require "rails_helper"

describe "User edits a supplier" do
  it "and access edit form from supplier page" do
    #arrange
    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")
    #act
    visit supplier_path(supplier.id)
    click_on "Edit"
    #assert
    expect(page).to have_field("Corporate name")
    expect(page).to have_field("Brand name")
    expect(page).to have_field("Registration number")
    expect(page).to have_field("Adress")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Email")
  end

  it "sucessfully" do
    #arrange
    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")
    #act
    visit supplier_path(supplier.id)
    click_on "Edit"
    fill_in "Corporate name", with: "Clube de Regatas Flamengo"
    click_on "Save"
    #assert
    expect(current_path).to eq(supplier_path(supplier.id))
    expect(page).to have_content("Clube de Regatas Flamengo")
  end
end
