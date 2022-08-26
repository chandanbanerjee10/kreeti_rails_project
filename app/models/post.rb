class Post < ApplicationRecord
    paginates_per 2
    belongs_to :user
    has_one_attached :file
    belongs_to :job

    # Validations
    validates :name, presence: true
    validates :post_description, presence: true
    VALID_USERNAME = /\A([a-zA-Z]){2}([0-9a-zA-Z_.@\-\s]){1,25}\z/
    validates :username, presence: true, uniqueness: { case_sensitive: false },
                format:{with: VALID_USERNAME}
    validates :phone_number, presence: true, numericality: true, length: {minimum: 10, maximum: 10}
    validates :city, presence: true, format:{with: /\A[a-zA-Z]+(?:[\s-][a-zA-Z]+)*\z/}
    validates :file, presence: true
end