#
class Player < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team
  belongs_to :club

  belongs_to :position

  def full_name
    "#{first_name} #{last_name} "
  end
end
