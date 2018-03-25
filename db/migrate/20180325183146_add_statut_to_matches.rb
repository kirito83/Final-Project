class AddStatutToMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :statut, :boolean, default: true
  end
end
