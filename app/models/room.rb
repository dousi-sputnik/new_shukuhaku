class Room < ApplicationRecord
  mount_uploader :room_image, ImageUploader
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :room_name, presence: true
  validates :description, presence: true
  validates :fee, presence: true
  validates :address, presence: true
end
