class AddRoleToPlayer < ActiveRecord::Migration[5.0]
  def change
	add_column :players, :admin, :boolean, default: false
  end
end
