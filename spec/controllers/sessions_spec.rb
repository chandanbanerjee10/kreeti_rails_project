require 'rails_helper'

describe SessionsController do
    describe "GET#new" do
        it "renders the login page" do
            get :new
            expect(response).to render_template('new')  
        end
    end
end

def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
        uid: "12345678910",
        info: {
          name: "chandan banerjee",
          email: "chandan@gmail.com",
          first_name: "chandan",
          last_name: "banerjee"
        },
        credentials: {
          token: "abcdefg12345",
          refresh_token: "abcdefg12345",
          expires_at: DateTime.now,
        }
    })
end

RSpec.feature "Sessions create, destroy and Google Login" do
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
        scenario "using google oauth2 'omniauth'" do
            stub_omniauth
            visit root_path
            click_link 'Login'
            click_button "Log in with Google"
            expect(page).to have_content("chandan banerjee")
            expect(page).to have_content("You have logged in successfully")
            expect(page).to have_content("Logout")
        end
    end
end