class Day < ApplicationRecord
  has_many :work_sessions
  has_many :activities, through: :work_sessions

  scope :open, -> {where.not(started_at: nil).where(ended_at: nil)}

  def open?
    started_at.present? && ended_at.nil?
  end

  def self.current_or_create
    open.last || create(started_at: Time.now)
  end
end
