class Type < ApplicationRecord
    has_many :sector_types
    has_many :sectors, through: :sector_types
end