require "rails_helper"

describe "User acess home page and" do
  it "sees app name" do
    #arrange

    #act
    visit("/")

    #assert
    expect(page).to have_content("Warehouses & Inventory")
  end
end
