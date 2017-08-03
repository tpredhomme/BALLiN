# Basic controller for Homepage
class HomepageController < ApplicationController
  def show
    @hello = 'Hello you'
  end
end
