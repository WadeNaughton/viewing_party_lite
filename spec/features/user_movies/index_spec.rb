require 'rails_helper'

RSpec.describe 'Movie Discover Page' do
  describe 'home page link' do
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
      visit "/dashboard/discover"

      click_link('Home')
      expect(current_path).to eq(root_path)
    end

    it 'shows movie details', :vcr do
      visit "/dashboard/movies?query=top%40rated"

      expect(page).to have_link("The Shawshank Redemption")
      expect(page).to have_content("Vote Average: 8.7")

    end
  end
end
