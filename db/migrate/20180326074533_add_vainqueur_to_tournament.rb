class AddVainqueurToTournament < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :vainqueur, :string
  end
end
