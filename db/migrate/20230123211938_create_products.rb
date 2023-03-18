class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :photo
      t.integer :price_per_day
      t.string :city
      t.integer :capacity
      t.string :location
      t.float :latitude
      t.float :longitude
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
