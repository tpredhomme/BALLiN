class AddAttrToPlayer < ActiveRecord::Migration[5.0]
  def change
  	add_column :players, :best_foot, :string
  	add_column :players, :best_side, :string
  	add_column :players, :right_foot_juggles, :integer
  	add_column :players, :left_foot_juggles, :integer
  	add_column :players, :head_juggles, :integer
  	add_column :players, :stamina, :string
  	add_column :players, :speed, :string
  	add_column :players, :jump, :string
  end
end
