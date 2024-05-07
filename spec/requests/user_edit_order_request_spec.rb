require 'rails_helper'

describe 'User edits an order' do
  it 'and its not the order owner' do
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

    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.day.from_now)
    #act
    login_as(user_2)
    patch(order_path(order.id), params: { order: { supplier_id: 3 }})
    #assert
    expect(response).to redirect_to(root_path)
  end
end
