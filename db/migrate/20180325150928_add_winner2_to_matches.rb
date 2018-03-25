class AddWinner2ToMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :winner2, :string
  end
end
