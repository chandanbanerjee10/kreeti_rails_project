require 'rails_helper'

describe SessionsController do
    describe "GET#new" do
        it "renders the login page" do
            get :new
            expect(response).to render_template('new')  
        end
    end
end


RSpec.feature "Sessions create, destroy and omniauth" do
    describe "POST#create" do
        before :each do
            @user = create(:candidate)
            @admin = create(:admin)
        end

        scenario "creates a session for the user trying to login" do
           visit "/" 
           click_link 'Login'
           fill_in "Email", with: @user.email
           fill_in "Password", with: @user.password
           click_button "Log In"
           expect(page).to have_current_path(user_path(@user)) 
           expect(page).to_not have_link("Log In") 
        end

        scenario "creates a session for the admin trying to login" do
           visit "/" 
           click_link 'Login'
           fill_in "Email", with: @admin.email
           fill_in "Password", with: @admin.password
           click_button "Log In"
           expect(page).to have_current_path(admin_path) 
           expect(page).to_not have_link("Log In") 
        end

        scenario "renders the session for incorrect login" do
           visit "/" 
           click_link 'Login'
           fill_in "Email", with: "abc@gmail.com"
           fill_in "Password", with: "12345"
           click_button "Log In"
           assert current_path == "/login" 
        end
    end

    describe "DELETE#destroy" do
        before :each do
            @user = create(:candidate)
            visit "/" 
            click_link 'Login'
            fill_in "Email", with: @user.email
            fill_in "Password", with: @user.password
            click_button "Log In"
        end

        scenario "redirects to root path after logout" do
            click_link 'Logout'
            expect(page).to have_content("Logged out Successfully")
        end
    end

    describe "sessions#omniauth" do
        scenario "Log in with google feature" do
            visit "/"
            click_link 'Login'
            click_button 'Log in with Google'
            expect(page).to have_content("You have logged in successfully")
        end
    end
end