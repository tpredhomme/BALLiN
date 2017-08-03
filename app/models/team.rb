#
class Team < ApplicationRecord
  belongs_to :club
  belongs_to :category
  belongs_to :level
  belongs_to :division
  belongs_to :group
end
