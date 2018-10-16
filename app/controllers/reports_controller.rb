class ReportsController < ApplicationController
  before_action :set_report, only: :show

  def show
    @days = @report.days.order(started_at: :asc).includes(work_sessions: :activities)
    respond_to :xlsx
  end

  def create
    @report = Report.new(days: Day.ready_to_report)

    if @report.save
      redirect_to overview_days_path, notice: 'Report saved.'
    else
      redirect_to overview_days_path, notice: @report.errors
    end
  end

  private

  def set_report
    @report = Report.find params[:id]
  end
end
