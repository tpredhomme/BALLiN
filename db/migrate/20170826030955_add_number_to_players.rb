class AddNumberToPlayers < ActiveRecord::Migration[5.0]
  def change
  	add_column :players, :number, :integer
  end
end
