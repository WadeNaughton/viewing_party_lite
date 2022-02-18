require 'rails_helper'

RSpec.describe 'Welcome Index Page' do
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
      visit root_path

      click_link('Home')
      expect(current_path).to eq(root_path)
    end

    it 'displays the title of the application' do
      visit root_path

      expect(page).to have_content("Viewing Party Lite")
    end

    it 'includes a button to create a new user' do
      visit root_path

      click_button('Create a New User')
      expect(current_path).to eq("/register")

      fill_in :name, with: 'Wade'
      fill_in :email, with: 'Wade@email.com'
      fill_in :password, with: 'test'
      fill_in :password_confirmation, with: 'test'
      click_button 'Submit'

      expect(page).to have_content("Wade")
    end

    it 'lists the existing users which link to their dashboard' do
      user_1 = User.create!(name: "David", email: "david@email.com", password: 'test', password_confirmation: 'test')
      user_2 = User.create!(name: "Wade", email: "wade@email.com", password: 'test', password_confirmation: 'test')
      user_3 = User.create!(name: "Robin", email: "robin@email.com", password: 'test', password_confirmation: 'test')

      visit root_path

      within "#user-#{user_1.id}" do
        expect(page).to have_link("#{user_1.email}")
        click_link("#{user_1.email}")
      end

      expect(current_path).to eq("/dashboard")
    end
  end
end
