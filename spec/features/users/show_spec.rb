require 'rails_helper'

RSpec.describe 'User Show Page' do
  describe 'view' do
    before(:each) do
      @user_1 = User.create!(name: 'user_1', email: 'email@gmail.com', password: '1234', password_confirmation: '1234')
      @party_1 = @user_1.parties.create!(duration: 180, day: "December 12, 2021", start_time: "7:00 pm", movie_id: 1, user_id: @user_1.id)
      visit "/login"
      fill_in "Email", with: "#{@user_1.email}"
      fill_in "Password", with: "#{@user_1.password}"
      click_button("Login")
      expect(current_path).to eq("/dashboard")
    end

    it 'has a home link which takes the user back to the home page' do
      visit "/dashboard"

      click_link('Home')
      expect(current_path).to eq(root_path)
    end

    it 'includes users name Dashboard" at the top of the page' do
      visit "/dashboard"

      expect(page).to have_content("user_1's Dashboard")
    end

    it 'includes A button to Discover Movies' do
      visit "/dashboard"

      expect(page).to have_link("Discover Movies")
      click_link("Discover Movies")
      expect(current_path).to eq("/dashboard/discover")
    end

    it 'has a section for viewing parties' do
      visit "/dashboard"

      expect(page).to have_content(@party_1.day)
      expect(page).to have_content(@party_1.start_time)
    end
  end
end
