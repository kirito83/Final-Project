class AddCategoryToTournament < ActiveRecord::Migration[5.1]
  def change
    add_reference :tournaments, :category, foreign_key: true
  end
end
