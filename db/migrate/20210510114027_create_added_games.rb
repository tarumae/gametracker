class CreateAddedGames < ActiveRecord::Migration[6.0]
  def change
    create_table :added_games do |t|
      t.references :tracker, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
