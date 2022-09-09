FactoryBot.define do
    factory :job, class: Job do
        sector factory: :sector
        type factory: :type
        user factory: :recruiter
        title {"Web Developer"}
        job_description {"This is a post for web developers"}
        job_location {"Baidyabati"}
        keyskills {"Ruby on Rails"}
        organisation_name {"Kreeti Technologies"}
    end
end