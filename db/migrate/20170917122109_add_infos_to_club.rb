class AddInfosToClub < ActiveRecord::Migration[5.0]
  def change
  	add_column :clubs, :adress, :string
  	add_column :clubs, :fields, :string
  	add_column :clubs, :contact, :string
  end
end
