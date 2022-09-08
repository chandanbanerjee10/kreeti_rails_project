FactoryBot.define do
    factory :type, class: Type do
        user factory: :admin
        name {'Clerk'}
    end

    factory :invalid_type, class: Type do
        user factory: :admin
        name {'99Clerk'}
    end
end