class AddJoueur1ToMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :joueur1, :string
  end
end
