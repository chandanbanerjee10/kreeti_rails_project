class Sector < ApplicationRecord
  has_many :sector_types
  has_many :types, through: :sector_types
end