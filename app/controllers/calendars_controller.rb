#
class CalendarsController < ApplicationController
  def show
    @calendar = Calendar.find(params[:id])
  end

  private

  def calendar_params
    params.require(:calendar).permit(:saison)
  end
end
