class Post < ApplicationRecord
    paginates_per 2
    belongs_to :user
    has_one_attached :file
    belongs_to :job
    

    # Validations
    validates :name, presence: true
    validates :post_description, presence: true
    validates :username, presence: true
    validates :phone_number, presence: true
    validates :city, presence: true
end