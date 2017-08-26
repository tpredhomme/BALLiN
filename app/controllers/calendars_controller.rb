#
class CalendarsController < ApplicationController
  def index
    # @calendars = Calendar.all
    @calendar = "calendars/calendar_#{player.club.id}.jpg"
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = Calendar.new(calendar_params)

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def calendar_params
    params.require(:calendar).permit(:saison)
  end
end
