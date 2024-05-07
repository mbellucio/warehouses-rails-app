require 'rails_helper'

describe 'User updates the order status' do
  it 'sets as delivered' do
    #arrange
    user = User.create!(name: "Ademiro", email: "ademiro@gmail.com",
    password: "flamengo2019")

    warehouse = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.day.from_now, status: :pending)
    #act
    login_as(user)
    visit root_path
    click_on "My orders"
    within("div##{order.code}") do
      click_on "View details"
    end
    click_on "Set as delivered"
    #assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Order status: delivered"
    expect(page).not_to have_button "Set as canceled"
    expect(page).not_to have_button "Set as delivered"
  end

  it 'sets as canceled' do
    #arrange
    user = User.create!(name: "Ademiro", email: "ademiro@gmail.com",
    password: "flamengo2019")

    warehouse = Warehouse.create!(name: "Rio", code: "SDU",
    city: "Rio de Janeiro", area: 60_000, adress: "Test 1110",
    zip: "1000-10", description: "test_a")

    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.day.from_now, status: :pending)
    #act
    login_as(user)
    visit root_path
    click_on "My orders"
    within("div##{order.code}") do
      click_on "View details"
    end
    click_on "Set as canceled"
    #assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Order status: canceled"
  end
end
