class AddScoreToGame < ActiveRecord::Migration[5.0]
  def change
  	add_column :games, :score, :string
  end
end
