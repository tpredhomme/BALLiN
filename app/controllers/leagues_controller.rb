#
class LeaguesController < ApplicationController
  before_action :set_league, only: [:edit, :update, :destroy]

  def index
    @leagues = League.all
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)

    respond_to do |format|
      if @league.save
        format.html { redirect_to leagues_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @league.update(league_params)
        format.html { redirect_to leagues_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @league.destroy

    respond_to do |format|
      format.html { redirect_to leagues_path }
      format.json { head :no_content }
    end
  end

  private

  def set_league
    @league = League.find params[:id]
  end

  def league_params
    params.require(:league).permit(:name)
  end
end
