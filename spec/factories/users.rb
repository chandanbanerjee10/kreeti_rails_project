FactoryBot.define do
    factory :admin, class: User do
      username {'admin'}
      email {'admin@gmail.com'}
      password {'admin123'}
      role { :admin}
    end
  
    # factory :random_user, class: User do
    #   username { Faker::Name.username }
    #   email { Faker::Internet.safe_email }
    #   password 'password'
    #   role :candidate
    # end
end