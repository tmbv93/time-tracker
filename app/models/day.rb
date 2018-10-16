class Day < ApplicationRecord
  has_many :work_sessions, dependent: :destroy
  has_many :activities, through: :work_sessions

  belongs_to :report

  scope :open, -> {where.not(started_at: nil).where(ended_at: nil)}
  scope :closed, -> {where.not(ended_at: nil)}
  scope :reported, -> {where.not(report_id: nil)}
  scope :ready_to_report, -> {closed.where(report_id: nil)}

  def open?
    started_at.present? && ended_at.nil?
  end

  def active?
    open? && work_sessions.open.any?
  end

  def work_time
    work_sessions.sum(&:work_time)
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
