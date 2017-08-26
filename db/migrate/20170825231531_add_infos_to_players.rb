class AddInfosToPlayers < ActiveRecord::Migration[5.0]
  def change
  	add_column :players, :age, :integer
  	add_column :players, :height, :integer
  	add_column :players, :weight, :integer
  end
end
