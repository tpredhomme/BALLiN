#
class DivisionsController < ApplicationController
  before_action :set_division, only: [:edit, :update, :destroy]

  def index
    @divisions = Division.all
  end

  def new
    @division = Division.new
  end

  def create
    @division = Division.create(division_params)

    respond_to do |format|
      if @division.save
        format.html { redirect_to divisions_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @division.update(division_params)
        format.html { redirect_to divisions_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @division.destroy

    respond_to do |format|
      format.html { redirect_to divisions_path }
    end
  end

  private

  def set_division
    @division = Division.find(params[:id])
  end

  def division_params
    params.require(:division).permit(:name)
  end
end
