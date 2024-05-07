require "rails_helper"

describe "User authenticates" do
  it "with success" do
    #arrange
    User.create!(email: "admin@gmail.com", password: "flamengo2019")
    #act
    visit root_path
    click_on "Login"
    within("main#main form") do
      fill_in "Email", with: "admin@gmail.com"
      fill_in "Password",	with: "flamengo2019"
      click_on "Login"
    end
    #assert
    within("nav") do
      expect(page).to have_button "Logout"
      expect(page).not_to have_link "Login"
      expect(page).to have_content "<admin@gmail.com>"
    end
    expect(page).to have_content "Signed in successfully."
  end

  it "and then logout" do
    #arrange
    User.create!(email: "admin@gmail.com", password: "flamengo2019")
    #act
    visit root_path
    click_on "Login"
    within("main#main form") do
      fill_in "Email", with: "admin@gmail.com"
      fill_in "Password",	with: "flamengo2019"
      click_on "Login"
    end
    click_on "Logout"
    #assert
    expect(page).to have_content "Signed out successfully."
    expect(page).to have_content "Login"
    expect(page).not_to have_content "Logout"
    expect(page).not_to have_content "admin@gmail.com"
  end
end
