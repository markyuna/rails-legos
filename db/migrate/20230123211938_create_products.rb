class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :city
      t.string :photo
      t.integer :capacity
      t.float :price
      t.float :latitude
      t.float :longitude
      t.date :start_date
      t.date :end_date
      t.boolean :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
