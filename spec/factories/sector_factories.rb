FactoryBot.define do
    factory :sector, class: Sector do
        user factory: :admin
        name {'Banking'}
    end

    factory :invalid_sector, class: Sector do
        user factory: :admin
        name {'99Banking'}
    end
end