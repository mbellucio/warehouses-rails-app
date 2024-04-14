require "rails_helper"

describe "User register a supplier" do
  it "and access the register form from the suppliers page" do
    #arrange

    #act
    visit suppliers_path
    click_on "Register supplier"
    #assert
    expect(current_path).to eq(new_supplier_path)

    expect(page).to have_field("Corporate name")
    expect(page).to have_field("Brand name")
    expect(page).to have_field("Registration number")
    expect(page).to have_field("Adress")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Email")
  end

  it "sucessfully" do
    #arrange

    #act
    visit suppliers_path
    click_on "Register supplier"

    fill_in "Corporate name", with: "Flamengo"
    fill_in "Brand name", with: "CRF"
    fill_in "Registration number", with: "112345"
    fill_in "Adress", with: "Gávea 10"
    fill_in "City", with: "Rio de Janeiro"
    fill_in "State", with: "RJ"
    fill_in "Email", with: "flamengo@gmail.com"
    click_on "Save"
    #assert
    expect(page).to have_content("Flamengo")
    expect(page).to have_content("112345")
    expect(page).to have_content("Gávea 10")
  end

  it "with incomplete data" do
    #arrange
    #act
    visit suppliers_path
    click_on "Register supplier"
    click_on "Save"
    #assert
    expect(page).to have_content "Corporate name can't be blank"
    expect(page).to have_content "Brand name can't be blank"
    expect(page).to have_content "Registration number can't be blank"
    expect(page).to have_content "Adress can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Email is invalid"
    expect(page).to have_content "State is the wrong length (should be 2 characters)"
  end
end
