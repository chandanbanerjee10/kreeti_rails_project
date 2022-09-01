class User < ApplicationRecord
    before_save { self.email = email.downcase }
    paginates_per 9
    enum role: [:candidate, :recruiter, :admin]
    VALID_USERNAME = /\A([a-zA-Z]){2}([0-9a-zA-Z_.@\-\s]){1,25}\z/
    validates :username, presence: true, uniqueness: { case_sensitive: false },
                format:{with: VALID_USERNAME}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false },
                format:{ with: VALID_EMAIL_REGEX}
    
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    

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