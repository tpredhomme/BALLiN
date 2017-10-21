#
class Player < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team, required: false
  belongs_to :club

  has_and_belongs_to_many :game

  belongs_to :position

  def full_name
    "#{first_name} #{last_name} "
  end

  def player_name
    "#{number} #{full_name}"
  end
end
