require "rails_helper"

describe "User access a supplier details page" do
  it  "and see additional supplier informations" do
    #arrange
    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    #act
    visit suppliers_path
    click_on "Flamengo"
    #assert
    expect(current_path).to eq(supplier_path(supplier.id))

    expect(page).to have_content("Flamengo")
    expect(page).to have_content("CRF")
    expect(page).to have_content("Registration number: 112345")
    expect(page).to have_content("Adress: Gávea 40")
    expect(page).to have_content("City: Rio de Janeiro")
    expect(page).to have_content("State: RJ")
    expect(page).to have_content("Email: flamengo@gmail.com")
  end

  it "and returns to suppliers page" do
    #arrange
    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    #act
    visit suppliers_path
    click_on "Flamengo"
    click_on "Back"
    #assert
    expect(current_path).to eq(suppliers_path)
  end
end
