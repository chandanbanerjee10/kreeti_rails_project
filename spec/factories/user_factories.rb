FactoryBot.define do
    factory :admin, class: User do
      sequence(:username) {|n|"admin#{n}"}
      sequence(:email) {|n|"admin#{n}@gmail.com"}
      password {'admin123'}
      role { :admin}
    end
  
    factory :candidate, class: User do
      sequence(:username) {|n|"candidate#{n}"}
      sequence(:email) {|n| "candidate#{n}@mail.com"}
      password {'candidate123'}
      role {:candidate}
    end

    factory :recruiter, class: User do
      sequence(:username) {|n|"recruiter#{n}"}
      sequence(:email) {|n| "recruiter#{n}@mail.com"}
      password {'recruiter123'}
      role {:recruiter}
    end

    factory :valid_user, class: User do 
      sequence(:username) { |n| "johndoe#{n}"}
      sequence(:email) { |n| "johndoe#{n}@example.com"}
      password {'password'}
      role {:candidate}
    end

    factory :invalid_user, class: User do
      username {nil}
    end
end



