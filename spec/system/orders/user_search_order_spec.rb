require 'rails_helper'

describe 'User search order' do
  it 'from the menu' do
    #arrange
    user = User.create!(name: "Ademiro", email: "admin@gmail.com",
    password: "flamengo2019")
    #act
    login_as(user)
    visit root_path
    #assert
    within("nav") do
      expect(page).to have_field("Search order")
      expect(page).to have_button("Search")
    end
  end

  it "has to be authenticated" do
    #arrange

    #act
    visit root_path
    #assert
    within("nav") do
      expect(page).not_to have_field("Search order")
      expect(page).not_to have_button("Search")
    end
  end

  it "and finds an order" do
    #arrange
    user = User.create!(name: "Ademiro", email: "admin@gmail.com",
    password: "flamengo2019")

    warehouse = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)

    #act
    login_as(user)
    visit root_path
    fill_in "Search order",	with: order.code
    click_on "Search"
    #assert
    expect(page).to have_content "Search results for: #{order.code}"
    expect(page).to have_content "Code: #{order.code}"
    expect(page).to have_content "Destination warehouse: Rio"
    expect(page).to have_content "Supplier: Flamengo"
    expect(page).to have_content "Estimated arrival date: #{order.arrival_date}"
  end

  it "And find multiple orders" do
    #arrange
    user = User.create!(name: "Ademiro", email: "admin@gmail.com",
    password: "flamengo2019")

    warehouse1 = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")
    warehouse2 = Warehouse.create!(name: "Guarulhos", code: "GRU",
    city: "São Paulo", area: 90_000, adress: "Test 2133",
    zip: "1000-22", description: "test_b")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("SDU1234567")
    order1 = Order.create!(warehouse: warehouse1, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("GRU1234567")
    order2 = Order.create!(warehouse: warehouse2, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("GRU7654321")
    order3 = Order.create!(warehouse: warehouse2, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)

    #act
    login_as(user)
    visit root_path
    fill_in "Search order",	with: "GRU"
    click_on "Search"
    #assert
    expect(page).to have_content "2 orders were found"
    expect(page).to have_content "GRU1234567"
    expect(page).to have_content "GRU7654321"
    expect(page).not_to have_content "SDU1234567"
  end
end
