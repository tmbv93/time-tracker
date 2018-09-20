class DaysController < ApplicationController
  before_action :set_day, only: [:show, :update]

  def index
    @day = Day.open.last
    render :show
  end

  def show
  end

  def update
    @day.close
    respond_to :js
  end
  
  private

  def set_day
    if params[:id] == 'current'
      @day = Day.current_or_create
    else
      @day = Day.open.find(params[:id])
    end
  end
end
