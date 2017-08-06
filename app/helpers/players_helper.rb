#
module PlayersHelper
  def player_full_name(player)
    "#{player.first_name} #{player.last_name}"
  end
end
