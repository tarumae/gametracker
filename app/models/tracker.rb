class Tracker < ApplicationRecord
  belongs_to :user
  has_many :added_games, dependent: :destroy
  has_many :games, through: :added_games

  validates :name, presence: true
end
