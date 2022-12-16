class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :person, presence: true

  validate :date_before_start
  validate :start_end_check

  def date_before_start
    return if start_date.blank?
    if self.start_date < Date.today
      errors.add(:start_date, "は本日以降の日付でお願いします")
    end
  end

  def start_end_check
    return if end_date.blank? || start_date.blank?
    if self.end_date < self.start_date
      errors.add(:end_date, "は開始日以降の選択でお願いします")
    end
  end
end
