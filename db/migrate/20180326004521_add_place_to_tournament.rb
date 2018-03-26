class AddPlaceToTournament < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :place, :string
  end
end
