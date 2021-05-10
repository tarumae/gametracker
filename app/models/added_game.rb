class AddedGame < ApplicationRecord
  belongs_to :tracker
  belongs_to :game
end
