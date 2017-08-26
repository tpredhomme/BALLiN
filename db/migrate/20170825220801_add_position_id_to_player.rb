class AddPositionIdToPlayer < ActiveRecord::Migration[5.0]
  def change
  	add_reference :players, :position, foreign_key: true
  end
end
