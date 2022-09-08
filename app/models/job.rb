class Job < ApplicationRecord
    paginates_per 3
    belongs_to :user
    belongs_to :type
    belongs_to :sector
    has_many :posts, dependent: :destroy
    has_many :reviews, dependent: :destroy

    # Validations
    validates :title, presence: true, length: { minimum: 1, maximum: 25 }
    validates :job_description, presence: true
    validates :job_location, presence: true
    validates :keyskills, presence: true
    validates :organisation_name, presence: true

    # Scope
    scope :sector, ->(abc) { joins(:sector).where("name LIKE?", "%#{abc}%")}
    scope :type, ->(abc) { joins(:type).where("name LIKE?", "%#{abc}%")}
end