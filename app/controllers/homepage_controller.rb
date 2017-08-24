# Basic controller for Homepage
class HomepageController < ApplicationController
  def show
    redirect_to player if player_signed_in?

    @facebook_link = 'https://www.facebook.com/teamballinfc/'
    @instagram_link = 'https://www.instagram.com/teamballinfc/'
    @twitter_link = 'https://twitter.com/teamballinfc/'
  end
end
