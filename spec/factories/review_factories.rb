FactoryBot.define do
    factory :review, class: Review do
        user factory: :candidate
        job factory: :job
        content {'Working here will give you a great experience'}
    end
end