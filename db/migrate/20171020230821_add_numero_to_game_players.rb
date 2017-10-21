class AddNumeroToGamePlayers < ActiveRecord::Migration[5.0]
  def change
  	add_column :games_players, :number, :integer
  end
end
