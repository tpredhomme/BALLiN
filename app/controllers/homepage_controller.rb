# Basic controller for Homepage
class HomepageController < ApplicationController
  def show
    redirect_to player if player_signed_in?
  end
end
