class AddedGame < ApplicationRecord
  belongs_to :tracker
  belongs_to :game

  validates :game, uniqueness: { scope: :tracker}
  GAMES = Game.all
end
