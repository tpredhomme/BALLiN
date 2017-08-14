# Basic controller for Homepage
class HomepageController < ApplicationController
  def show
    @models = [:clubs, :teams, :players, :categories, :divisions, :groups, :levels, :calendars, :leagues, :days, :games]
  end
end
