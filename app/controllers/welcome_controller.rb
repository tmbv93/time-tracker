class WelcomeController < ApplicationController
  def index
    @day = Day.open.last
  end
end
