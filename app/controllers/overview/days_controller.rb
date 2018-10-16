module Overview
  class DaysController < ApplicationController
    before_action :set_day, only: :edit

    def edit
    end

    def index
      @days = Day.ready_to_report.includes(:work_sessions)
      @reports = Report.all.includes(days: :work_sessions).order(created_at: :desc)
    end

    private

    def set_day
      @day = Day.find params[:id]
    end
  end
end
