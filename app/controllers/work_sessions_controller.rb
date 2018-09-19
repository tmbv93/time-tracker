class WorkSessionsController < ApplicationController
  before_action :set_work_session, only: :update

  def create
    @work_session = WorkSession.current_or_create
    respond_to :js
  end

  def update
    @work_session.close
    respond_to :js
  end

  private

  def set_work_session
    if params[:id] == 'current'
      @work_session = WorkSession.current_or_create
    else
      @work_session = WorkSession.open.find(params[:id])
    end
  end

  def work_session_params
    params.require(:work_session)
  end
end
