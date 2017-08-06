class AddPlayerIdToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :player_id, :integer
    add_index :clubs, :player_id
  end
end
