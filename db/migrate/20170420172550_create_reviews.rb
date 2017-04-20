class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :merchant_id
      t.integer :item_id
      t.string :review
      t.integer :rating

      t.timestamps
    end
  end
end
