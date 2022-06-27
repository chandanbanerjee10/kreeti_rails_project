class Job < ApplicationRecord
    paginates_per 3
    belongs_to :user
    belongs_to :type
    belongs_to :sector
    has_many :posts, dependent: :destroy
    has_many :reviews

    # Validations
    validates :title, presence: true, length: { minimum: 1, maximum: 25 }
    validates :job_description, presence: true
    validates :job_location, presence: true
    validates :keyskills, presence: true
end