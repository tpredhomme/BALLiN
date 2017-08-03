class RenameGroupeTypo < ActiveRecord::Migration[5.0]
  def change
  	rename_column :teams, :groupe_id, :group_id
  end
end
