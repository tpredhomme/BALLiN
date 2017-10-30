#
class PositionsController < ApplicationController
  before_action :set_position, only: [:edit, :update, :destroy]

  def index
    @positions = Position.all
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new(position_params)

    respond_to do |format|
      if @position.save
        format.html { redirect_to positions_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to positions_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @position.destroy
    redirect_to :back
  end

  private

  def set_position
    @position = Position.find(params[:id])
  end

  def position_params
    params.require(:position).permit(:name)
  end
end
