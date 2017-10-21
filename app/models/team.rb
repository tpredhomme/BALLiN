#
class Team < ApplicationRecord
  belongs_to :category
  belongs_to :level
  belongs_to :division
  belongs_to :group
  belongs_to :league

  belongs_to :club

  has_many :players

  has_and_belongs_to_many :games

  def full_infos
    "#{category.name} #{level.name} #{division.name}"
  end
end
