class Sector < ApplicationRecord
  has_many :sectors_types
  has_many :types, through: :sectors_types
end