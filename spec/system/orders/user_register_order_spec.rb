require "rails_helper"

describe "User issues an order" do
  it "and must be authenticated" do
    #arrange
    #act
    visit root_path
    click_on "Issue order"
    #assert
    expect(current_path).to eq new_user_session_path
  end

  it "successfully" do
    #arrange
    user = User.create!(name: "Ademiro", email: "admin@gmail.com",
    password: "flamengo2019")

    warehouse = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")
    Warehouse.create!(name: "Maceio", code: "MCZ",
    city: "Maceio", area: 50_000, adress: "Test 2220",
    zip: "2000-20", description: "test_b")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")
    Supplier.create!(corporate_name: "São Paulo", brand_name: "SPFC",
    registration_number: "223456", adress: "Morumbi 10",
    city: "São Paulo", state: "SP", email: "saopaulo@gmail.com")

    #act
    login_as(user)
    visit root_path
    click_on "Issue order"
    select "Rio", from: "Destination warehouse"
    select "Flamengo", from: "Supplier"
    fill_in "Arrival date",	with: "07-12-2024"
    click_on "Order"
    #assert
    expect(page).to have_content "Order was successfully issued"
    expect(page).to have_content "Issued by: Ademiro <admin@gmail.com>"
    expect(page).to have_content "Destination warehouse: Rio"
    expect(page).to have_content "Supplier: Flamengo"
    expect(page).to have_content "Predicted arrival date: 2024-12-07"
    expect(current_path).to eq(order_path(Order.last.id))
  end
end
