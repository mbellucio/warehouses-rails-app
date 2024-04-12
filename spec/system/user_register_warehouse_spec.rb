require "rails_helper"

describe "User register a Warehouse" do
    it "from main page" do
      #assert

      #act
      visit root_path
      click_on "Register Warehouse"

      #arrange
      expect(page).to have_field("Name")
      expect(page).to have_field("Description")
      expect(page).to have_field("Code")
      expect(page).to have_field("Adress")
      expect(page).to have_field("City")
      expect(page).to have_field("Zip")
      expect(page).to have_field("Area")
    end

    it "sucessfully" do
      #arrange

      #act
      visit root_path
      click_on "Register Warehouse"
      fill_in "Name",	with: "Rio de Janeiro"
      fill_in "Description",	with: "Galpão da zona portuária do Rio"
      fill_in "Code",	with: "RIO"
      fill_in "Adress",	with: "Avenida do Museu do Amanhã, 1000"
      fill_in "City",	with: "Rio de Janeiro"
      fill_in "Zip",	with: "20100-00"
      fill_in "Area",	with: 32000
      click_on "Save"

      #assert
      expect(current_path).to eq root_path
      expect(page).to have_content "Warehouse sucessfully registered!"
      expect(page).to have_content "Rio de Janeiro"
      expect(page).to have_content "RIO"
      expect(page).to have_content "32000 m2"
    end

    it "with incomplete data" do
      #arrange

      #act
      visit root_path
      click_on "Register Warehouse"
      fill_in "Name", with: ""
      fill_in "Description",	with: ""
      fill_in "Code",	with: ""
      click_on "Save"

      #assert
      expect(page).to have_content "Warehouse not registered."
      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Code can't be blank"
      expect(page).to have_content "Description can't be blank"
      expect(page).to have_content "Adress can't be blank"
      expect(page).to have_content "City can't be blank"
      expect(page).to have_content "Zip can't be blank"
      expect(page).to have_content "Area can't be blank"
      expect(page).to have_content "Code is the wrong length (should be 3 characters)"
    end
end
