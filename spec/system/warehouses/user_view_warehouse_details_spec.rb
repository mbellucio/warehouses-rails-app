require "rails_helper"

describe "User sees warehouse details and" do
  it "see aditional information" do
    #arrange
    Warehouse.create(
      name: "São Paulo",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      adress: "Avenida do Aeroporto, 1000",
      zip: "15000-000",
      description: "Warehouse for international cargo usage"
      )

    #act
    visit(root_path)
    click_on("São Paulo")

    #assert
    expect(page).to have_content("GRU")
    expect(page).to have_content("São Paulo")
    expect(page).to have_content("City: Guarulhos")
    expect(page).to have_content("Area: 100000 m2")
    expect(page).to have_content("Adress: Avenida do Aeroporto, 1000 zip: 15000-000")
    expect(page).to have_content("Warehouse for international cargo usage")
  end

  it "return to main page" do
    #arrange
    Warehouse.create(
      name: "São Paulo",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      adress: "Avenida do Aeroporto, 1000",
      zip: "15000-000",
      description: "Warehouse for international cargo usage"
      )
    #act
    visit(root_path)
    click_on("São Paulo")
    click_on("Back")
    #assert
    expect(current_path).to eq(root_path)
  end
end
