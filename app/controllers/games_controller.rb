#
class GamesController < ApplicationController
  before_action :set_game, only: [:edit, :update, :destroy]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])

    @team_ext = @game.teams.first
    @team_dom = @game.teams.second
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new game_params

    params[:game][:teams].each do |team_id|
      next if team_id.empty?
      @game.teams << Team.find(team_id)
    end

    respond_to do |format|
      if @game.save
        format.html { redirect_to games_path, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_path }
      format.json { head :no_content }
    end
  end

  private

  def set_game
    @game = Game.find params[:id]
  end

  def game_params
    params.require(:game).permit(:name, :day, :date, :datetime, :score)
  end
end
