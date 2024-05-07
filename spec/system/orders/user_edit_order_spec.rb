require 'rails_helper'

describe 'User edit order' do
  it 'and must be authenticated' do
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
    visit edit_order_path(order.id)
    #assert
    expect(current_path).to eq new_user_session_path
  end

  it "successfully" do
    #arrange
    user = User.create!(name: "Ademiro", email: "ademiro@gmail.com",
    password: "flamengo2019")

    warehouse = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    supplier = Supplier.create!(corporate_name: "IBM", brand_name: "Lenovo",
    registration_number: "123213123312", adress: "Vasco 20", city: "São Paulo",
    state: "SP", email: "imb@gmail.com")

    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)
    #act
    login_as(user)
    visit root_path
    click_on "My orders"
    within("div##{order.code}") do
      click_on "View details"
    end
    click_on "Edit"
    fill_in "Arrival date",	with: "2024-07-12"
    select "IBM", from: "Supplier"
    click_on "Update"
    #assert
    expect(page).to have_content "Order was successfully updated"
    expect(page).to have_content "Destination warehouse: SDU | Rio"
    expect(page).to have_content "Supplier: IBM"
  end

  it 'if he is the responsible for the order' do
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
    visit edit_order_path(order.id)
    #assert
    expect(current_path).to eq root_path\
    expect(page).to have_content "You don't have access to that order"
  end
end
