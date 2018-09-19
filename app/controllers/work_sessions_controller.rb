class WorkSessionsController < ApplicationController
  def create
    @work_session = WorkSession.current_or_create
    respond_to :js
  end

  private

  def work_session_params
    params.require(:work_session)
  end
end
