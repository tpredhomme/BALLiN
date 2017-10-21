#
class EnterGamesController < ApplicationController
  def create
    game   = Game.find params[:game_id]
    player = Player.find params[:player_id]

    game.players << player
    redirect_to :back
  end
end
