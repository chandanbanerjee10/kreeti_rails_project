class Type < ApplicationRecord
    paginates_per 9
    validates :name, presence: true, length: { minimum: 3, maximum: 25 },
    uniqueness: { case_sensitive: false }
    belongs_to :user
    has_many :jobs
end