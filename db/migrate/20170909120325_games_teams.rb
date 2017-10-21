class GamesTeams < ActiveRecord::Migration[5.0]
  def change
  	create_table 'games_teams', :id => false do |t|
    	t.column :game_id, :integer
    	t.column :team_id, :integer
  end
  end
end
