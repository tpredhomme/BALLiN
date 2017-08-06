#
class Club < ApplicationRecord
  has_many :teams
  has_many :players
end
