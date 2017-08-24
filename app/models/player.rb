#
class Player < ApplicationRecord
  before_save :default_values

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team
  belongs_to :club

  def full_name
    "#{first_name} #{last_name} "
  end

  # One team/club tournament configuration
  def default_values
    self.team_id = 1
  end
end
