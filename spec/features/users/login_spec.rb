require 'rails_helper'

RSpec.describe "Logging In" do
  before(:each) do
    @user_1 = User.create!(name: 'user_1', email: 'email@gmail.com', password: '1234', password_confirmation: '1234')
    @party_1 = @user_1.parties.create!(duration: 180, day: "December 12, 2021", start_time: "7:00 pm", movie_id: 1, user_id: @user_1.id)
    visit "/login"
    fill_in "Email", with: "#{@user_1.email}"
    fill_in "Password", with: "#{@user_1.password}"
    click_button("Login")
    expect(current_path).to eq("/dashboard")
  end
  it "can log in with valid credentials" do

    visit root_path

    click_on "Login"

    expect(current_path).to eq('/login')

    fill_in :email, with: @user_1.email
    fill_in :password, with: @user_1.password

    click_on "Login"

    expect(current_path).to eq("/dashboard")

    expect(page).to have_content("Welcome, #{@user_1.email}")
  end

  it "cannot log in with bad credentials" do
    user = User.create!(name: "David", email: "david@email.com", password: 'test', password_confirmation: 'test')

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: "incorrect password"

    click_on "Login"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end
