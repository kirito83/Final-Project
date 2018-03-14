class CreateTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.integer :pricepool

      t.timestamps
    end
  end
end
