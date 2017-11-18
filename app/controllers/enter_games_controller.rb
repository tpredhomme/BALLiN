#
class EnterGamesController < ApplicationController
  def create
    game   = Game.find params[:game_params][:game_id]
    player = Player.find params[:game_params][:player_id]

    player.number = params[:game_params][:numero]
   	player.save

    game.players << player
    redirect_to :back
  end
end
