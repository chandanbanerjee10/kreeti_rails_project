# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

<!-- User.where(User.arel_table[:first_name].matches("%#{first_name}%")) -->

      # it 'successfully creates a new user' do
      #   expect{
      #       post :create, params: { :user => { username: "testuser", password: "asdfasdf", email: "abc@gmail.com" } }
      #     }.to change(User,:count).by(1)
      # end

      # it "redirects to users#show" do
      #   new_user = FactoryBot.create :user
      #   session[:user_id] = new_user.id
      #   expect(
      #     post :create, params: {  user: { username: new_user.username, email: new_user.email, password: new_user.password} }              
      #   ).to redirect_to(User.last)
      # end