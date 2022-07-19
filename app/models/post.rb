class Post < ApplicationRecord
    paginates_per 2
    belongs_to :user
    has_one_attached :file
    belongs_to :job
    
end