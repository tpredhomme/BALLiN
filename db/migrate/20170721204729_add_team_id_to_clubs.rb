class AddTeamIdToClubs < ActiveRecord::Migration[5.0]
  def change
  	add_column :clubs, :team_id, :integer
    add_index :clubs, :team_id
  end
end
