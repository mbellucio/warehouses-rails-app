require "rails_helper"

describe "User access suppliers page" do
  it "and see no registered supplier" do
    #arrange

    #act
    visit root_path
    within("nav") do
      click_on "Suppliers"
    end
    #assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content("There are no registered Suppliers")
  end

  it "and sees all registered suppliers" do
    #arrange
    Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    Supplier.create!(corporate_name: "São Paulo", brand_name: "SPFC",
    registration_number: "223456", adress: "Morumbi 10",
    city: "São Paulo", state: "SP", email: "saopaulo@gmail.com")

    #act
    visit root_path
    within("nav") do
      click_on "Suppliers"
    end

    #assert
    expect(current_path).to eq suppliers_path

    expect(page).to have_content("Flamengo")
    expect(page).to have_content("CRF")
    expect(page).to have_content("RJ")

    expect(page).to have_content("São Paulo")
    expect(page).to have_content("SPFC")
    expect(page).to have_content("SP")
  end

  it "and returns to home page" do
    #arrange
    #act
    visit suppliers_path
    click_on "Back"
    #assert
    expect(current_path).to eq(root_path)
  end
end
