class AddWinnersToTournament < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :winners, :string, array: true
  end
end
