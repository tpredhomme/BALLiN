class AddRsToPlayer < ActiveRecord::Migration[5.0]
  def change
  	add_column :players, :snapchat, :string
  	add_column :players, :instagram, :string
  	rename_column :players, :age, :birthday
  end
end
