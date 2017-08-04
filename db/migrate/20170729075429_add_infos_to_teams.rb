class AddInfosToTeams < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :category, foreign_key: true
    add_reference :teams, :level, foreign_key: true
    add_reference :teams, :division, foreign_key: true
    add_reference :teams, :group, foreign_key: true
  end
end

