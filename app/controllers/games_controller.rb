#
class GamesController < ApplicationController
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
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :day, :date, :datetime)
  end
end
