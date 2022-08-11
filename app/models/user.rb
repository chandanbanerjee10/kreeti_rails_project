class User < ApplicationRecord
    # before_save { self.email = email.downcase }
    paginates_per 9
    enum role: [:candidate, :recruiter, :admin]
    validates :username, presence: true, length: { minimum: 3, maximum: 25 },
                 uniqueness: { case_sensitive: false }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false },
                format:{ with: VALID_EMAIL_REGEX}
    
    has_secure_password

    # Posts
    has_many :posts, dependent: :destroy

    # Sectors & Types
    has_many :sectors
    has_many :types

    #Jobs
    has_many :jobs, dependent: :destroy

    # Messages
    has_many :messages, dependent: :destroy
    # Reviews
    has_many :reviews

    def is_admin?
        role == "admin"
    end

    def is_recruiter?
        role == "recruiter"
    end

    def is_candidate?
        role == "candidate"
    end    
end