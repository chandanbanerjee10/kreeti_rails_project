require 'rails_helper'

RSpec.feature "Home Page" do
    scenario "visits the root page" do
        visit "/"
        assert current_path == "/" 
    end
end