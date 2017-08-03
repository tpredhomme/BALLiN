class AddClubHasManyTeam < ActiveRecord::Migration[5.0]
  def change
	remove_column :clubs, :team_id, :integer
  	
  	change_table :teams do |t|
      t.belongs_to :club, index: true
    end
  end
end
