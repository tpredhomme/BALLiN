#
class AdminController < ApplicationController
  before_action :allow_access

  def allow_access
    redirect_to root_path if !player || !player.try(:admin)
  end
end
