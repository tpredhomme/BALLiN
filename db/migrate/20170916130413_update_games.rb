class UpdateGames < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :games, :team, foreign_key: true

  	add_column :games, :day, :integer
  	add_column :games, :datetime, :datetime
  	add_column :games, :date, :date
  end
end
