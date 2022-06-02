class Job < ApplicationRecord
    belongs_to :user
    belongs_to :type
    belongs_to :sector

    # Validations
    validates :title, presence: true, length: { minimum: 1, maximum: 25 }
    validates :job_description, presence: true
    validates :job_location, presence: true
    validates :keyskills, presence: true
end