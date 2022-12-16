class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :rooms
  has_many :bookings, dependent: :destroy
  
  mount_uploader :profile_image, ImageUploader
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 1, maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :introduction, length:{ minimum: 4, maximum: 300 },
                            allow_nil: true
  has_secure_password
  validates :password, length: { minimum: 7 },
                       confirmation: true
  validates :password_confirmation, presence: true
end
