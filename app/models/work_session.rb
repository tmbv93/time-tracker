class WorkSession < ApplicationRecord
  belongs_to :day
  has_many :activities, dependent: :destroy

  scope :open, -> {where.not(started_at: nil).where(ended_at: nil)}
  scope :timeline, -> {order(started_at: :asc)}
  scope :feed, -> {timeline.includes(:day, :activities)}


  def open?
    started_at.present? && ended_at.nil?
  end

  def after_break?(last_work_session)
    return false if last_work_session.nil?
    return false if last_work_session.open?
    started_at > last_work_session.ended_at  #+ 1.minute
  end

  def close
    update(ended_at: Time.current)
  end

  def self.current
    open.last
  end

  def self.current_or_create
    current || create(day: Day.current_or_create, started_at: Time.current)
  end
end
