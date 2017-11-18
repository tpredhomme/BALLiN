#
class Player < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  belongs_to :team, required: false
  belongs_to :club, required: false

  has_and_belongs_to_many :game

  belongs_to :position

  def full_name
    "#{first_name} #{last_name} "
  end

  def player_name
    "#{number} - #{full_name} - #{position.name}"
  end

  def admin?
    admin
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end
end
