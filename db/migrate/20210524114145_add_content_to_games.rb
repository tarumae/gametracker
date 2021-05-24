class AddContentToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :content, :text
  end
end
