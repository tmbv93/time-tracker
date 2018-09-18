class WorkSession < ApplicationRecord
  belongs_to :day
  has_many :activities

  scope :open, -> {where.not(started_at: nil).where(ended_at: nil)}

  def open?
    started_at.present? && ended_at.nil?
  end

  def self.current_or_create
    open.last || create(day: Day.current_or_create, started_at: Time.now)
  end
end
