class Type < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 },
    uniqueness: { case_sensitive: false }
    belongs_to :user
    has_many :jobs, dependent: :destroy
end