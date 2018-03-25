class AddWinner1ToMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :winner1, :string
  end
end
