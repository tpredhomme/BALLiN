class AddUserNameToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :user_name, :string
  end
end
