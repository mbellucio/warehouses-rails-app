require 'rails_helper'

describe 'User view stock' do
  it 'on warehouse screen' do
    #arrange
    supplier = Supplier.create!(corporate_name: "Flamengo", brand_name: "CRF",
    registration_number: "112345", adress: "Gávea 40", city: "Rio de Janeiro",
    state: "RJ", email: "flamengo@gmail.com")

    warehouse = Warehouse.create!(
    name: "São Paulo",
    code: "GRU",
    city: "Guarulhos",
    area: 100_000,
    adress: "Avenida do Aeroporto, 1000",
    zip: "15000-000",
    description: "Warehouse for international cargo usage"
    )

    user = User.create!(name: "Matheus", email: "admin@gmail.com", password: "flamengo2019")
    order = Order.create!(warehouse: warehouse, supplier: supplier,
    user: user, arrival_date: 1.week.from_now, status: :delivered)
    product = ProductModel.create!(name: "Lenovo Notebook", weight: 2000, width: 65, height:35,
    depth: 6, sku: "#DDDDD77", supplier: supplier)
    product_2 = ProductModel.create!(name: "Dell Notebook", weight: 2000, width: 65, height:35,
    depth: 6, sku: "#GGGGG88", supplier: supplier)
    product_3 = ProductModel.create!(name: "Apple Notebook", weight: 2000, width: 65, height:35,
    depth: 6, sku: "#HHHHH99", supplier: supplier)
    #act
    3.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product)}
    2.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product_2)}
    #act
    login_as(user)
    visit root_path
    click_on warehouse.name
    #assert
    expect(page).to have_content "Stock items"
    expect(page).to have_content "3 x #DDDDD77"
    expect(page).to have_content "2 x #GGGGG88"
    expect(page).not_to have_content "2 x #HHHHH99"
  end
end
