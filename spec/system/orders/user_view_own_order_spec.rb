require 'rails_helper'

describe 'User view own orders' do
  it 'and must be authenticated' do
    #arrange

    #act
    visit root_path
    #assert
    expect(page).not_to have_link "My Orders"
  end

  it "and dont see other users orders" do
    #arrange
    user_1 = User.create!(name: "Ademiro", email: "ademiro@gmail.com",
    password: "flamengo2019")
    user_2 = User.create!(name: "Admin", email: "admin@gmail.com",
    password: "flamengo2019")

    warehouse = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("SDU1000022")
    order1 = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user_1, arrival_date: 1.day.from_now, status: "pending")
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("SDU1000033")
    order2 = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user_2, arrival_date: 1.day.from_now, status: "delivered")
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("SDU1000044")
    order3 = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user_1, arrival_date: 1.day.from_now, status: "canceled")
    #act
    login_as(user_1)
    visit orders_path
    #assert
    expect(page).to have_content("SDU1000022")
    expect(page).to have_content("pending")
    expect(page).to have_content("canceled")
    expect(page).not_to have_content("delivered")
    expect(page).to have_content("SDU1000044")
    expect(page).not_to have_content("SDU1000033")
  end

  it "and visits a order" do
    #arrange
    user = User.create!(name: "Ademiro", email: "ademiro@gmail.com",
    password: "flamengo2019")

    warehouse = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("SDU1000022")
    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)
    #act
    login_as(user)
    visit orders_path
    within("div##{order.code}") do
      click_on "View details"
    end
    #assert
    expect(page).to have_content "Order Details"
    expect(page).to have_content "SDU1000022"
    expect(page).to have_content "Destination warehouse: SDU | Rio"
    expect(page).to have_content "Supplier: Flamengo"
    expect(page).to have_content "Predicted arrival date: #{1.day.from_now.strftime('%Y-%m-%d')}"
  end

  it "and dont visit orders from other users" do
     #arrange
     user = User.create!(name: "Ademiro", email: "ademiro@gmail.com",
     password: "flamengo2019")

     user_2 = User.create!(name: "admin", email: "admin@gmail.com",
     password: "flamengo2019")

     warehouse = Warehouse.create!(name: "Rio", code: "SDU",
     city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
     zip: "1000-10", description: "test_a")

     supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
     registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
     state: "RJ", email: "flamengo@gmail.com")

     allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("SDU1000022")
     order = Order.create!(warehouse: warehouse, supplier: supplier,
     user: user, arrival_date: 1.day.from_now)
     #act
     login_as(user_2)
     visit root_path
     visit order_path(order.id)
     #assert
     expect(current_path).not_to eq order_path(order.id)
     expect(current_path).to eq root_path
     expect(page).to have_content "You don't have access to that order"

  end

  it "and see order items" do
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
    product_c = ProductModel.create!(name: "Apple Notebook", weight: 1900, width: 60, height:30,
    depth: 5, sku: "#ssdhtjlk1213334", supplier: supplier)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("SDU1000022")
    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)

    OrderItem.create!(product_model: product_a, order: order, quantity: 20)
    OrderItem.create!(product_model: product_b, order: order, quantity: 15)
    OrderItem.create!(product_model: product_c, order: order, quantity: 10)

    #act
    login_as(user)
    visit orders_path
    within("div##{order.code}") do
      click_on "View details"
    end
    #assert
    expect(page).to have_content "Order items"
    expect(page).to have_content "20 x Lenovo Notebook"
    expect(page).to have_content "15 x Dell Notebook"
    expect(page).to have_content "10 x Apple Notebook"
  end
end
