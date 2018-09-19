class WorkSession < ApplicationRecord
  belongs_to :day
  has_many :activities, dependent: :destroy

  scope :open, -> {where.not(started_at: nil).where(ended_at: nil)}

  scope :feed, -> {order(started_at: :desc).includes(:day, :activities)}

  def open?
    started_at.present? && ended_at.nil?
  end

  def self.current_or_create
    open.last || create(day: Day.current_or_create, started_at: Time.current)
  end
end
