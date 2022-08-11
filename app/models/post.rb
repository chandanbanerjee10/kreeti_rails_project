class Post < ApplicationRecord
    paginates_per 2
    belongs_to :user
    has_one_attached :file
    belongs_to :job
    

    # Validations
    validates :name, presence: true
    validates :post_description, presence: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :phone_number, presence: true, numericality: true, length: {minimum: 10, maximum: 10}
    validates :city, presence: true
    # validates :file, presence: true
end