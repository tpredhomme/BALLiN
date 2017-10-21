class GamesPlayers < ActiveRecord::Migration[5.0]
  def change
  	create_table 'games_players', :id => false do |t|
    	t.column :game_id, :integer
    	t.column :player_id, :integer
  end
  end
end
