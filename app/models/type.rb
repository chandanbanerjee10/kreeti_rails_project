class Type < ApplicationRecord
    has_many :sectors_types
    has_many :sectors, through: :sectors_types
end