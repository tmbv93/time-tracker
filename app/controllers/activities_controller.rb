class ActivitiesController < ApplicationController
  before_action :set_activity, only: :update
  before_action :set_work_session, only: :create

  def create
    @work_session.activities.create(activity_params)
    respond_to do |format|
      format.js {render layout: false, content_type: 'text/javascript' }
    end
  end

  def update
    @activity.update(activity_params)
    render json: @activity
  end

  private

  def set_activity
    @activity = Activity.find params[:id]
  end

  def set_work_session
    if params[:work_session_id] == 'current'
      @work_session = WorkSession.current_or_create
    else
      @work_session = WorkSession.open.find(params[:work_session_id])
    end
  end

  def activity_params
    params.require(:activity).permit(:description)
  end
end
