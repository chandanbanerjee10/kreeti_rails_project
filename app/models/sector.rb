class Sector < ApplicationRecord
  paginates_per 9
  VALID_NAME = /\A([a-zA-Z]){2}([0-9a-zA-Z_.@\-\s]){1,25}\z/
  validates :name, presence: true,
  uniqueness: { case_sensitive: false } , format:{with: VALID_NAME}
  # belongs_to :user
  # has_many :jobs
end