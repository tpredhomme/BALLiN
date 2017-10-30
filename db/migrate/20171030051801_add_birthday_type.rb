class AddBirthdayType < ActiveRecord::Migration[5.0]
  def change
  	add_column(:players, :birthday, :datetime)
  end
end
