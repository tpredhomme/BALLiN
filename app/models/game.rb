#
class Game < ApplicationRecord
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :players

  def finished?
    !score.nil?
  end
end
