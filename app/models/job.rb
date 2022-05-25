class Job < ApplicationRecord
    belongs_to :user
    belongs_to :type
    belongs_to :sector
end