class Type < ApplicationRecord
    has_many :sector_types
    has_many :sectors, through: :sector_types
    has_many :types, through: :sector_types
    validates :name, presence: true, length: { minimum: 3, maximum: 25 },
    uniqueness: { case_sensitive: false }
    belongs_to :user
end