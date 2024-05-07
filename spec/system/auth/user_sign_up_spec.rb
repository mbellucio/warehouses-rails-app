require "rails_helper"

describe "User signs up and authenticates" do
  it "with success" do
    #arrange
    #act
    visit root_path
    click_on "Login"
    click_on "Sign up"
    within("main#main form") do
      fill_in "Name", with: "Ademiro"
      fill_in "Email", with: "admin@gmail.com"
      fill_in "Password", with: "flamengo2019"
      fill_in "Password confirmation", with: "flamengo2019"
      click_on "Sign up"
    end
    #assert
    expect(page).to have_content "admin@gmail.com"
    expect(page).to have_button "Logout"
    expect(page).to have_content "Welcome! You have signed up successfully."
    user = User.last
    expect(user.name).to eq "Ademiro"
  end
end
