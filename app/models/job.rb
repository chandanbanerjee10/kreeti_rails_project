class Job < ApplicationRecord
    paginates_per 3
    belongs_to :user
    belongs_to :type
    belongs_to :sector
    has_many :posts, dependent: :destroy
    has_many :reviews, dependent: :destroy

    # Validations
    VALID_TITLE = /\A([a-zA-Z]){2}([a-zA-Z\-\s]){1,25}([0-9]){0,2}\z/
    validates :title, presence: true, format: {with: VALID_TITLE}
    validates :job_description, presence: true
    VALID_NAMES = /\A([a-zA-Z]){2}[^`!@#\$%\^&*+_=]+\z/
    validates :job_location, presence: true, length: {minimum: 3, maximum: 40}, format: {with: VALID_NAMES}
    validates :keyskills, presence: true, length: {minimum: 2}, format: {with: VALID_NAMES}
    validates :organisation_name, presence: true, length: { minimum: 3, maximum: 40}, format: {with: VALID_NAMES}

    # Scope
    scope :sector, ->(abc) { joins(:sector).where("name LIKE?", "%#{abc}%")}
    scope :type, ->(abc) { joins(:type).where("name LIKE?", "%#{abc}%")}
end