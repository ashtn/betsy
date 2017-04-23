class RemoveReviewsColumnAddForegeinKey < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :item_id

    add_reference :reviews, :item, index: true, foreign_key: true
  end
end
