#
class PlayersController < ApplicationController
  before_action :redirect_to_club_selection, only: :show

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_path
  end

  private

  def redirect_to_club_selection
    redirect_to selects_club_path unless player.club && player.team
  end
end
