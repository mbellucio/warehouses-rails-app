require 'rails_helper'

describe 'User add item to order' do
  it 'successfully' do
    #arrange
    user = User.create!(name: "Ademiro", email: "ademiro@gmail.com",
    password: "flamengo2019")

    warehouse = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    product_a = ProductModel.create!(name: "Lenovo Notebook", weight: 2000, width: 65, height:35,
    depth: 6, sku: "#ssdhtjlk1213457", supplier: supplier)
    product_b = ProductModel.create!(name: "Dell Notebook", weight: 2500, width: 70, height:40,
    depth: 8, sku: "#ssdhtjlk1213567", supplier: supplier)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("SDU1000022")
    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)
    #act
    login_as(user)
    visit root_path
    click_on "My orders"
    within("div##{order.code}") do
      click_on "View details"
    end
    click_on "Add item"
    select "Lenovo Notebook", from: "Product"
    fill_in "Quantity",	with: 20
    click_on "Save"
    #assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Item added successfully!"
    expect(page).to have_content "20 x Lenovo Notebook"
  end

  it "and dont see other suppliers product" do
    #arrange
    user = User.create!(name: "Ademiro", email: "ademiro@gmail.com",
    password: "flamengo2019")

    warehouse = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    supplier_2 = Supplier.create!(corporate_name: "Vasco", brand_name: "CRV",
    registration_number: "11231123", adress: "Barreira do vasco 40", city: "Rio de Janeiro",
    state: "RJ", email: "vasco@gmail.com")

    product_a = ProductModel.create!(name: "Lenovo Notebook", weight: 2000, width: 65, height:35,
    depth: 6, sku: "#ssdhtjlk1213457", supplier: supplier)
    product_b = ProductModel.create!(name: "Dell Notebook", weight: 2500, width: 70, height:40,
    depth: 8, sku: "#ssdhtjlk1213567", supplier: supplier_2)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("SDU1000022")
    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)
    #act
    login_as(user)
    visit root_path
    click_on "My orders"
    within("div##{order.code}") do
      click_on "View details"
    end
    click_on "Add item"
    #assert
    expect(page).to have_content "Lenovo Notebook"
    expect(page).not_to have_content "Dell Notebook"
  end
end
