class AddClubIdToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :club_id, :integer
    add_index :players, :club_id

    remove_column :clubs, :player_id, :integer
  end
end
