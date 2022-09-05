FactoryBot.define do
    factory :admin, class: User do
      username {'admin'}
      email {'admin@gmail.com'}
      password {'admin123'}
      role { :admin}
    end
  
    factory :candidate, class: User do
      username {'candidate'}
      email { 'candidate@mail.com'}
      password {'candidate123'}
      role {:candidate}
    end

    factory :recruiter, class: User do
      username {'recruiter'}
      email { 'recruiter@mail.com'}
      password {'recruiter123'}
      role {:recruiter}
    end

    factory :user do |f|
      f.username { Faker::Internet.username }
      f.email { Faker::Internet.email }
      password{'password'}
    end
end



