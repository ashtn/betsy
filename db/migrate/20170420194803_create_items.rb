class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :merchant_id
      t.string :name
      t.string :description
      t.float :price
      t.integer :inventory
      t.string :photo

      t.timestamps
    end
  end
end
