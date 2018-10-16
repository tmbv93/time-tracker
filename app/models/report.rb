class Report < ApplicationRecord
  has_many :days, dependent: :nullify
  has_many :work_sessions, through: :days

  def work_time
    work_sessions.sum(&:work_time)
  end
end
