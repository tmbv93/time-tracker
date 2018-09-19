module WorkSessionsHelper
  def formatted_wait_time(work_session)
    return "#{local_time(work_session.started_at, '%H:M')}" if work_session.open?
    "#{local_time(work_session.started_at, '%H:M')} - #{local_time(work_session.ended_at, '%H:M')}"
  end
end
