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

  def work_time
    work_sessions.sum {|ws| ws.ended_at - ws.started_at}
  end

  def self.current
    open.last
  end

  def close
    last_session = work_sessions.timeline.last
    last_session.update(ended_at: Time.current) if last_session.open?
    update(ended_at: last_session.ended_at)
  end

  def self.current_or_create
    current || create(started_at: Time.current)
  end
end
