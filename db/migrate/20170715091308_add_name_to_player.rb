class AddNameToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :first_name, :string
    add_column :players, :last_name, :string
  end
end
