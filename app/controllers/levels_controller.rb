#
class LevelsController < ApplicationController
  before_action :set_level, only: [:edit, :update, :destroy]

  def index
    @levels = Level.all
  end

  def new
    @level = Level.new
  end

  def create
    @level = Level.create(level_params)

    respond_to do |format|
      if @level.save
        format.html { redirect_to levels_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @level.update(level_params)
        format.html { redirect_to levels_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @level.destroy

    respond_to do |format|
      format.html { redirect_to levels_path }
      format.json { head :no_content }
    end
  end

  private

  def set_level
    @level = Level.find(params[:id])
  end

  def level_params
    params.require(:level).permit(:name)
  end
end
