FactoryBot.define do
    factory :post, class: Post do
        job factory: :job
        user factory: :candidate
        name {"Chandan Banerjee"}
        post_description {"I want to apply for this job"}
        username {"chandan_3456"}
        phone_number {9123064180}
        city {"kolkata"}
        file { Rack::Test::UploadedFile.new('app/assets/files/rspec.pdf', 'rspec.pdf') }
    end
end