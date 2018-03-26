class AddGameToTournament < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :game, :string
  end
end
