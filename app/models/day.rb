class Day < ApplicationRecord
  has_many :work_sessions, dependent: :destroy
  has_many :activities, through: :work_sessions

  scope :open, -> {where.not(started_at: nil).where(ended_at: nil)}

  def open?
    started_at.present? && ended_at.nil?
  end

  def active?
    open? && work_sessions.open.any?
  end

  def self.current_or_create
    open.last || create(started_at: Time.current)
  end
end
