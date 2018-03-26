class AddMaxPlayersToTournament < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :maxPlayers, :integer
  end
end
