class ChangeBirthdayType < ActiveRecord::Migration[5.0]
  def change
  	remove_column(:players, :birthday, :integer)
  end
end
