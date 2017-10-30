#
class SelectsController < ApplicationController
  def club
    @clubs = Club.all
  end

  def team
    club    = Club.find(params[:id])
    @teams  = club.teams
  end

  def create
    player.club = Club.find(params[:club_id])
    player.team = Team.find(params[:team_id])
    player.save
    redirect_to root_path
  end
end
